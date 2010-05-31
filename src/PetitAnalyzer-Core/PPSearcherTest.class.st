Class {
	#name : #PPSearcherTest,
	#superclass : #PPAbstractParseTest,
	#instVars : [
		'searcher'
	],
	#category : #'PetitAnalyzer-Tests'
}

{ #category : #running }
PPSearcherTest >> setUp [
	searcher := PPSearcher new
]

{ #category : #testing }
PPSearcherTest >> testAnyPattern [
	| result |
	searcher
		matches: PPPattern any
		do: [ :parser :answer | answer add: parser; yourself ].

	result := searcher
		execute: ($a asParser)
		initialAnswer: OrderedCollection new.
	self assert: result size = 1.
	
	result := searcher
		execute: ($a asParser star)
		initialAnswer: OrderedCollection new.
	self assert: result size = 2.
	
	result := searcher
		execute: ($a asParser , $b asParser)
		initialAnswer: OrderedCollection new.
	self assert: result size = 3
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchAction [
	| old new |
	old := $a asParser ==> [ :token | $b ].
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchDelegate [
	| old new |
	old := $a asParser token trim.
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchEpsilon [
	| old new |
	old := PPEpsilonParser new.
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchFailure [
	| old new |
	old := PPFailingParser message: 'problem'.
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchList [
	| old new |
	old := $a asParser , $b asParser , $c asParser.
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchLiteral [
	| old new |
	old := $a asParser.
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchPluggable [
	| old new |
	old := [ :stream | ] asParser.
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchPredicate [
	| old new |
	old := #word asParser.
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchRecursiveDelegate [
	| old new |
	old := PPDelegateParser new.
	old setParser: old.
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #'testing-copy' }
PPSearcherTest >> testCopyMatchRecursiveList [
	| old new |
	old := PPChoiceParser new.
	old setParsers: (Array with: old).
	new := old copyInContext: Dictionary new.
	self assert: (old match: old inContext: Dictionary new).
	self assert: (old match: new inContext: Dictionary new).
	self deny: (old == new).
]

{ #category : #testing }
PPSearcherTest >> testKindPattern [
	| result |
	searcher 
		matches: (PPPattern kind: PPLiteralObjectParser)
		do: [ :parser :answer | answer add: parser; yourself ].

	result := searcher
		execute: ($a asParser)
		initialAnswer: OrderedCollection new.
	self assert: result size = 1.
	self assert: (result allSatisfy: [ :each | each class = PPLiteralObjectParser ]).
	
	result := searcher
		execute: (#any asParser)
		initialAnswer: OrderedCollection new.
	self assert: result isEmpty.
	
	result := searcher
		execute: ($a asParser / #any asParser , $b asParser)
		initialAnswer: OrderedCollection new.
	self assert: result size = 2.
	self assert: (result allSatisfy: [ :each | each class = PPLiteralObjectParser ])
]

{ #category : #'testing-lists' }
PPSearcherTest >> testListInfix [
	| pattern result |
	searcher
		matches: PPListPattern any , $a asParser , PPListPattern any
		do: [ :parser :answer | true ].
	
	result := searcher
		execute: $a asParser , $a asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $a asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $a asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $b asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $a asParser , $a asParser , $a asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $a asParser , $a asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $a asParser , $b asParser , $a asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $a asParser , $a asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $b asParser , $a asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $a asParser , $b asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $a asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $b asParser , $b asParser
		initialAnswer: false.
	self deny: result
]

{ #category : #'testing-lists' }
PPSearcherTest >> testListPostfix [
	| pattern result |
	searcher
		matches: PPListPattern any , $b asParser
		do: [ :parser :answer | true ].
	
	result := searcher
		execute: $a asParser , $a asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $a asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $a asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $b asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $a asParser , $a asParser , $a asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $b asParser , $a asParser , $a asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $a asParser , $b asParser , $a asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $a asParser , $a asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $b asParser , $a asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $a asParser , $b asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $a asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $b asParser , $b asParser
		initialAnswer: false.
	self assert: result
]

{ #category : #'testing-lists' }
PPSearcherTest >> testListPrefix [
	| pattern result |
	searcher
		matches: $a asParser , PPListPattern any
		do: [ :parser :answer | true ].
	
	result := searcher
		execute: $a asParser , $a asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $a asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $a asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $b asParser , $b asParser
		initialAnswer: false.
	self deny: result.
	
	
	
	result := searcher
		execute: $a asParser , $a asParser , $a asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $a asParser , $a asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $a asParser , $b asParser , $a asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $a asParser , $a asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $b asParser , $a asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $a asParser , $b asParser , $b asParser
		initialAnswer: false.
	self assert: result.
	
	result := searcher
		execute: $b asParser , $a asParser , $b asParser
		initialAnswer: false.
	self deny: result.
	
	result := searcher
		execute: $b asParser , $b asParser , $b asParser
		initialAnswer: false.
	self deny: result
]

{ #category : #testing }
PPSearcherTest >> testMultiplePattern [
	| result |
	searcher
		matches: $a asParser
		do: [ :parser :answer | answer first add: parser. answer ].
	searcher
		matches: PPPattern any
		do: [ :parser :answer | answer second add: parser. answer ].

	result := searcher
		execute: $a asParser , $a asParser , $b asParser
		initialAnswer: (Array 
			with: OrderedCollection new 
			with: OrderedCollection new).
	self assert: result first size = 2.
	self assert: result second size = 4
]

{ #category : #testing }
PPSearcherTest >> testNamePattern [
	| result |
	searcher 
		matches: (PPPattern name: 'foo')
		do: [ :parser :answer | answer add: parser; yourself ].

	result := searcher 
		execute: ($a asParser)
		initialAnswer: OrderedCollection new.
	self assert: result isEmpty.
	
	result := searcher
		execute: ($a asParser name: 'foo')
		initialAnswer: OrderedCollection new.
	self assert: result size = 1.
	self assert: result first name = 'foo'.
	
	result := searcher
		execute: ($a asParser name: 'bar') , ($b asParser name: 'foo')
		initialAnswer: OrderedCollection new.
	self assert: result size = 1.
	self assert: result first name = 'foo'
]

{ #category : #testing }
PPSearcherTest >> testNewPattern [
	self 
		should: [ PPPattern new ]
		raise: Error
]

{ #category : #testing }
PPSearcherTest >> testRecursivePattern [
	| recursive |
	recursive := PPDelegateParser new.
	recursive setParser: recursive.
	searcher 
		matches: recursive 
		do: [ :parser :answer | parser ].
	
	self assert: (searcher execute: recursive) = recursive.
	self assert: (searcher execute: $a asParser) isNil.
	self assert: (searcher execute: $a asParser / $b asParser star) isNil
]

{ #category : #testing }
PPSearcherTest >> testRepeatedPattern [
	| pattern result |
	searcher
		matches: (pattern := PPPattern any) , pattern
		do: [ :parser :answer | answer add: parser; yourself ].

	result := searcher
		execute: ($a asParser , $b asParser)
		initialAnswer: OrderedCollection new.
	self assert: result isEmpty.
	
	result := searcher
		execute: $a asParser , $a asParser
		initialAnswer: OrderedCollection new.
	self assert: result size = 1.
	
	result := searcher
		execute: ($a asParser , ($a asParser , $b asParser))
		initialAnswer: OrderedCollection new.
	self assert: result isEmpty.
	
	result := searcher
		execute: ($b asParser , ($a asParser , $a asParser))
		initialAnswer: OrderedCollection new.
	self assert: result size = 1
]