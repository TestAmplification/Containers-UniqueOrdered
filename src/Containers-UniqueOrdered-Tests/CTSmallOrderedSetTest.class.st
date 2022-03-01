Class {
	#name : #CTSmallOrderedSetTest,
	#superclass : #TestCase,
	#instVars : [
		'collection'
	],
	#category : #'Containers-UniqueOrdered-Tests'
}

{ #category : #running }
CTSmallOrderedSetTest >> setUp [
	super setUp.
	collection := CTSmallOrderedSet new
]

{ #category : #testing }
CTSmallOrderedSetTest >> testAdd [
	| object |
	object := Object new.
	self assert: collection size equals: 0.
	self assert: (collection add: object) == object.
	self assert: collection size equals: 1.
	self assert: (collection add: object) == object.
	self assert: collection size equals: 1.
]

{ #category : #testing }
CTSmallOrderedSetTest >> testAddAll [
	collection addAll: #(2 1 1).
	self assert: collection size = 2.
	self assert: (collection includes: 1).
	self assert: (collection includes: 2)
]

{ #category : #'as yet unclassified' }
CTSmallOrderedSetTest >> testAdd_amp_A11 [

	"SmallAmp has derived this test from `CTSmallOrderedSetTest>>#testAdd` by applying some transformations and regenerating its assertions.
	This test can cover this part:
	*	In `CTSmallOrderedSet>> #remove:ifAbsent:` from 115 to 135:
		Operation: RemoveCaretOperator
		Code snippet: `^ aNiladicBlock value`
		Dynamic state: nil
		Mutant id: RemoveCaretOperator#CTSmallOrderedSet#remove:ifAbsent:#115#135
"

	<madeBySmallAmp>
	| object anUndefinedObject |
	anUndefinedObject := collection remove: 1 ifAbsent: [  ].
	self assert: anUndefinedObject isNil
]

{ #category : #testing }
CTSmallOrderedSetTest >> testAddingTwiceTheSameOnlyAddOne [
	| object |
	object := Object new.
	self assert: collection size equals: 0.
	collection add: object.
	self assert: collection size equals: 1.
	collection add: object.
	self assert: collection size equals: 1.
]

{ #category : #testing }
CTSmallOrderedSetTest >> testCopy [
	| copy |
	collection add: 1.
	copy := collection copy.
	collection add: 2.
	
	self assert: collection size equals: 2.
	self assert: copy size equals: 1.
	
	self assert: (collection includes: 2).
	self deny: (copy includes: 2).
]

{ #category : #testing }
CTSmallOrderedSetTest >> testDo [
	| seen |
	collection addAll: #(2 1 1).
	seen := Array streamContents: [ :stream |
		collection do: [ :each |
			stream nextPut: each ] ].
	self assert: seen size equals: 2.
	self assert: (seen at: 1) equals: 2.
	self assert: (seen at: 2) equals: 1
]

{ #category : #testing }
CTSmallOrderedSetTest >> testDoShouldIterateInOrder [
	| seen |
	collection addAll: #(1 2 1 1).
	seen := Array streamContents: [ :stream |
		collection do: [ :each |
			stream nextPut: each ] ].
	self assert: seen size equals: 2.
	self assert: (seen at: 1) equals: 1.
	self assert: (seen at: 2) equals: 2
]

{ #category : #testing }
CTSmallOrderedSetTest >> testIncludes [
	self deny: (collection includes: 0).
	collection add: 0.
	self assert: (collection includes: 0)
]

{ #category : #testing }
CTSmallOrderedSetTest >> testIsEmpty [
	self assert: collection isEmpty.
	collection add: 1.
	self deny: collection isEmpty.
	collection remove: 1.
	self assert: collection isEmpty
]

{ #category : #testing }
CTSmallOrderedSetTest >> testRemove [
	collection add: 1.
	self assert: (collection remove: 1) equals: 1.
	self should: [ collection remove: 1 ] raise: Error
]

{ #category : #testing }
CTSmallOrderedSetTest >> testRemoveIfAbsent [
	| absent |
	collection add: 1.
	absent := false.
	
	self assert: (collection remove: 1 ifAbsent: [ absent := true ]) equals: 1.
	self deny: absent.
	
	collection remove: 1 ifAbsent: [ absent := true ].
	self assert: absent.
]

{ #category : #testing }
CTSmallOrderedSetTest >> testSize [
	self assert: collection size equals: 0.
	collection addAll: #(2 1 1).
	self assert: collection size equals: 2.
]
