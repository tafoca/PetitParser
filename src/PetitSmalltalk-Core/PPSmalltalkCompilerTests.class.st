Class {
	#name : #PPSmalltalkCompilerTests,
	#superclass : #PPSmalltalkGrammarTests,
	#category : #'PetitSmalltalk-Tests'
}

{ #category : #private }
PPSmalltalkCompilerTests >> assert: aNode format: aString [ 
	aNode isCollection ifFalse: 
		[ ^ self 
			assert: (Array with: aNode)
			format: (Array with: aString) ].
	self assert: aNode size = aString size.
	aNode 
		with: aString
		do: [ :node :string | self assert: node formattedCode = string ]
]

{ #category : #accessing }
PPSmalltalkCompilerTests >> parserClass [
	^ PPSmalltalkCompiler
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testArgumentsBlock1 [
	super testArgumentsBlock1.
	self assert: result isBlock.
	self assert: result arguments size = 1.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testArgumentsBlock2 [
	super testArgumentsBlock2.
	self assert: result isBlock.
	self assert: result arguments size = 2.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result arguments second isVariable.
	self assert: result arguments second name = 'b'.
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testArgumentsBlock3 [
	super testArgumentsBlock3.
	self assert: result isBlock.
	self assert: result arguments size = 3.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result arguments second isVariable.
	self assert: result arguments second name = 'b'.
	self assert: result arguments third isVariable.
	self assert: result arguments third name = 'c'.
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral1 [
	super testArrayLiteral1.
	self assert: result isLiteral.
	self assert: result value = #()
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral10 [
	super testArrayLiteral10.
	self assert: result isLiteral.
	self assert: result value = #(#(1 2 ) #(1 2 3 ) )
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral11 [
	super testArrayLiteral11.
	self assert: result isLiteral.
	self assert: result value size = 2.
	self assert: (result value first isKindOf: ByteArray).
	self assert: result value first size = 2.
	self assert: (result value last isKindOf: ByteArray).
	self assert: result value last size = 3
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral2 [
	super testArrayLiteral2.
	self assert: result isLiteral.
	self assert: result value = #(1 )
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral3 [
	super testArrayLiteral3.
	self assert: result isLiteral.
	self assert: result value = #(1 2 )
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral4 [
	super testArrayLiteral4.
	self assert: result isLiteral.
	self assert: result value = #(true false nil )
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral5 [
	super testArrayLiteral5.
	self assert: result isLiteral.
	self assert: result value = #($a )
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral6 [
	super testArrayLiteral6.
	self assert: result isLiteral.
	self assert: result value = #(1.2 )
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral7 [
	super testArrayLiteral7.
	self assert: result isLiteral.
	self assert: result value = #(#size #at: #at:put: #'==' ).
	result value do: [ :each | self assert: each isSymbol ]
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral8 [
	super testArrayLiteral8.
	self assert: result isLiteral.
	self assert: result value = #('baz' ).
	self assert: result value first isString.
	self assert: result value first isSymbol not
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testArrayLiteral9 [
	super testArrayLiteral9.
	self assert: result isLiteral.
	self assert: result value = #(#(1 ) 2 )
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testAssignment1 [
	super testAssignment1.
	self assert: result isLiteral.
	self assert: result value = 1
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testAssignment2 [
	super testAssignment2.
	self assert: result isAssignment.
	self assert: result variable isVariable.
	self assert: result variable name = 'a'.
	self assert: result value isLiteral.
	self assert: result value value = 1
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testAssignment3 [
	super testAssignment3.
	self assert: result isAssignment.
	self assert: result variable isVariable.
	self assert: result variable name = 'a'.
	self assert: result value isAssignment.
	self assert: result value variable isVariable.
	self assert: result value variable name = 'b'.
	self assert: result value value isLiteral.
	self assert: result value value value = 1
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testAssignment4 [
	super testAssignment4.
	self assert: result isAssignment.
	self assert: result variable isVariable.
	self assert: result variable name = 'a'.
	self assert: result value isLiteral.
	self assert: result value value = 1
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testAssignment5 [
	super testAssignment5.
	self assert: result isAssignment.
	self assert: result variable isVariable.
	self assert: result variable name = 'a'.
	self assert: result value isAssignment.
	self assert: result value variable isVariable.
	self assert: result value variable name = 'b'.
	self assert: result value value isLiteral.
	self assert: result value value value = 1
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testBinaryExpression1 [
	super testBinaryExpression1.
	self assert: result isMessage.
	self assert: result receiver isLiteral.
	self assert: result receiver value = 1.
	self assert: result arguments size = 1.
	self assert: result arguments first isLiteral.
	self assert: result arguments first value = 2
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testBinaryExpression2 [
	super testBinaryExpression2.
	self assert: result isMessage.
	self assert: result receiver isMessage.
	self assert: result receiver receiver isLiteral.
	self assert: result receiver receiver value = 1.
	self assert: result receiver arguments size = 1.
	self assert: result receiver arguments first isLiteral.
	self assert: result receiver arguments first value = 2.
	self assert: result arguments size = 1.
	self assert: result arguments first isLiteral.
	self assert: result arguments first value = 3
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testBinaryMethod1 [
	super testBinaryMethod1.
	self assert: result isMethod.
	self assert: result selector = #+.
	self assert: result arguments size = 1.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testBinaryMethod2 [
	super testBinaryMethod2.
	self assert: result isMethod.
	self assert: result selector = #+.
	self assert: result arguments size = 1.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result body temporaries size = 1.
	self assert: result body statements isEmpty
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testBinaryMethod3 [
	super testBinaryMethod3.
	self assert: result isMethod.
	self assert: result selector = #+.
	self assert: result arguments size = 1.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result body temporaries isEmpty.
	self assert: result body statements size = 1
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testBinaryMethod4 [
	super testBinaryMethod4.
	self assert: result isMethod.
	self assert: result selector = #+.
	self assert: result arguments size = 1.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result body temporaries size = 1.
	self assert: result body statements size = 1
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testByteLiteral1 [
	super testByteLiteral1.
	self assert: result isLiteral.
	self assert: (result value isKindOf: ByteArray).
	self assert: result value isEmpty
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testByteLiteral2 [
	super testByteLiteral2.
	self assert: result isLiteral.
	self assert: (result value isKindOf: ByteArray).
	self assert: result value size = 1.
	self assert: result value first = 0
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testByteLiteral3 [
	super testByteLiteral3.
	self assert: result isLiteral.
	self assert: (result value isKindOf: ByteArray).
	self assert: result value size = 1.
	self assert: result value first = 255
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testByteLiteral4 [
	super testByteLiteral4.
	self assert: result isLiteral.
	self assert: (result value isKindOf: ByteArray).
	self assert: result value size = 2.
	self assert: result value first = 1.
	self assert: result value last = 2
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testByteLiteral5 [
	super testByteLiteral5.
	self assert: result isLiteral.
	self assert: (result value isKindOf: ByteArray).
	self assert: result value size = 3.
	self assert: result value first = 10.
	self assert: result value second = 63.
	self assert: result value last = 255
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testCascadeExpression1 [
	super testCascadeExpression1.
	self assert: result isCascade.
	self assert: result receiver isLiteral.
	self assert: result messages size = 2.
	self assert: result messages first receiver = result receiver.
	self assert: result messages first selector = #abs.
	self assert: result messages second receiver = result receiver.
	self assert: result messages second selector = #negated
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testCascadeExpression2 [
	super testCascadeExpression2.
	self assert: result isCascade.
	self assert: result receiver isMessage.
	self assert: result receiver receiver isLiteral.
	self assert: result receiver receiver value = 1.
	self assert: result receiver selector = #abs.
	self assert: result messages size = 3.
	self assert: result messages first receiver = result receiver.
	self assert: result messages first selector = #negated.
	self assert: result messages second receiver = result receiver.
	self assert: result messages second selector = #raisedTo:.
	self assert: result messages third receiver = result receiver.
	self assert: result messages third selector = #negated
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testCascadeExpression3 [
	super testCascadeExpression3.
	self assert: result isCascade.
	self assert: result receiver isLiteral.
	self assert: result receiver value = 1.
	self assert: result messages size = 2.
	self assert: result messages first receiver = result receiver.
	self assert: result messages first selector = #+.
	self assert: result messages first arguments size = 1.
	self assert: result messages second receiver = result receiver.
	self assert: result messages second selector = #-.
	self assert: result messages second arguments size = 1
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testCharLiteral1 [
	super testCharLiteral1.
	self assert: result isLiteral.
	self assert: result value = $a
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testCharLiteral2 [
	super testCharLiteral2.
	self assert: result isLiteral.
	self assert: result value = Character space
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testCharLiteral3 [
	super testCharLiteral3.
	self assert: result isLiteral.
	self assert: result value = $$
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testComment1 [
	super testComment1.
	self assert: result isMessage.
	self assert: result receiver isValue.
	self assert: result selector = #+.
	self assert: result arguments first isValue
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testComment2 [
	super testComment2.
	self assert: result isMessage.
	self assert: result receiver isValue.
	self assert: result selector = #+.
	self assert: result arguments first isValue
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testComment3 [
	super testComment3.
	self assert: result isMessage.
	self assert: result receiver isValue.
	self assert: result selector = #+.
	self assert: result arguments first isValue
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testComment4 [
	super testComment4.
	self assert: result isMessage.
	self assert: result receiver isValue.
	self assert: result selector = #+.
	self assert: result arguments first isValue
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testComment5 [
	super testComment5.
	self assert: result isMessage.
	self assert: result receiver isValue.
	self assert: result selector = #+.
	self assert: result arguments first isValue
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testComplexBlock1 [
	super testComplexBlock1.
	self assert: result isBlock.
	self assert: result arguments size = 1.
	self assert: result body temporaries size = 1.
	self assert: result body statements size = 1
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testComplexBlock2 [
	super testComplexBlock2.
	self assert: result isBlock.
	self assert: result arguments size = 1.
	self assert: result body temporaries size = 1.
	self assert: result body statements size = 1
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testKeywordExpression1 [
	super testKeywordExpression1.
	self assert: result isMessage.
	self assert: result receiver isLiteral.
	self assert: result receiver value = 1.
	self assert: result selector = #to:.
	self assert: result arguments size = 1.
	self assert: result arguments first isLiteral.
	self assert: result arguments first value = 2
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testKeywordExpression2 [
	super testKeywordExpression2.
	self assert: result isMessage.
	self assert: result receiver isLiteral.
	self assert: result selector = #to:by:.
	self assert: result arguments size = 2.
	self assert: result arguments first isLiteral.
	self assert: result arguments first value = 2.
	self assert: result arguments second isLiteral.
	self assert: result arguments second value = 3
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testKeywordExpression3 [
	super testKeywordExpression3.
	self assert: result isMessage.
	self assert: result receiver isLiteral.
	self assert: result selector = #to:by:do:.
	self assert: result arguments size = 3.
	self assert: result arguments first isLiteral.
	self assert: result arguments first value = 2.
	self assert: result arguments second isLiteral.
	self assert: result arguments second value = 3.
	self assert: result arguments third isLiteral.
	self assert: result arguments third value = 4
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testKeywordMethod1 [
	super testKeywordMethod1.
	self assert: result isMethod.
	self assert: result selector = #to:.
	self assert: result arguments size = 1.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testKeywordMethod2 [
	super testKeywordMethod2.
	self assert: result isMethod.
	self assert: result selector = #to:do:.
	self assert: result arguments size = 2.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result arguments second isVariable.
	self assert: result arguments second name = 'b'.
	self assert: result body temporaries size = 1.
	self assert: result body statements isEmpty
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testKeywordMethod3 [
	super testKeywordMethod3.
	self assert: result isMethod.
	self assert: result selector = #to:do:by:.
	self assert: result arguments size = 3.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result arguments second isVariable.
	self assert: result arguments second name = 'b'.
	self assert: result arguments third isVariable.
	self assert: result arguments third name = 'c'.
	self assert: result body temporaries isEmpty.
	self assert: result body statements size = 1
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testKeywordMethod4 [
	super testKeywordMethod4.
	self assert: result isMethod.
	self assert: result selector = #to:do:by:.
	self assert: result arguments size = 3.
	self assert: result arguments first isVariable.
	self assert: result arguments first name = 'a'.
	self assert: result arguments second isVariable.
	self assert: result arguments second name = 'b'.
	self assert: result arguments third isVariable.
	self assert: result arguments third name = 'c'.
	self assert: result body temporaries size = 1.
	self assert: result body statements size = 1
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testMethod1 [
	super testMethod1.
	self assert: result isMethod.
	self assert: result arguments isEmpty.
	self assert: result body temporaries isEmpty.
	self assert: result body statements size = 1.
	self assert: result body statements first isReturn.
	self assert: result body statements first value isMessage.
	self assert: result body statements first value receiver isLiteral.
	self assert: result body statements first value selector = #-.
	self assert: result body statements first value arguments size = 1.
	self assert: result body statements first value arguments first isVariable
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testMethod2 [
	super testMethod2.
	self assert: result isMethod.
	self assert: result arguments isEmpty.
	self assert: result body temporaries isEmpty.
	self assert: result body statements size = 1.
	self assert: result body statements first isReturn.
	self assert: result body statements first value isMessage.
	self assert: result body statements first value receiver isLiteral.
	self assert: result body statements first value selector = #-.
	self assert: result body statements first value arguments size = 1.
	self assert: result body statements first value arguments first isVariable
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testMethod3 [
	super testMethod3.
	self assert: result isMethod.
	self assert: result arguments isEmpty.
	self assert: result body temporaries isEmpty.
	self assert: result body statements size = 1.
	self assert: result body statements first isReturn.
	self assert: result body statements first value isMessage.
	self assert: result body statements first value receiver isLiteral.
	self assert: result body statements first value selector = #-.
	self assert: result body statements first value arguments size = 1.
	self assert: result body statements first value arguments first isVariable
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral1 [
	super testNumberLiteral1.
	self assert: result isLiteral.
	self assert: result value = 0
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral10 [
	super testNumberLiteral10.
	self assert: result isLiteral.
	self assert: result value = 10
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral11 [
	super testNumberLiteral11.
	self assert: result isLiteral.
	self assert: result value = 511
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral12 [
	super testNumberLiteral12.
	self assert: result isLiteral.
	self assert: result value = 175
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral13 [
	super testNumberLiteral13.
	self assert: result isLiteral.
	self assert: result value = 202.9921875
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral14 [
	super testNumberLiteral14.
	self assert: result isLiteral.
	self assert: result value floor = -9
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral2 [
	super testNumberLiteral2.
	self assert: result isLiteral.
	self assert: result value = 0.1
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral3 [
	super testNumberLiteral3.
	self assert: result isLiteral.
	self assert: result value = 123
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral4 [
	super testNumberLiteral4.
	self assert: result isLiteral.
	self assert: result value = 123.456
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral5 [
	super testNumberLiteral5.
	self assert: result isLiteral.
	self assert: result value = 0
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral6 [
	super testNumberLiteral6.
	self assert: result isLiteral.
	self assert: result value = -0.1
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral7 [
	super testNumberLiteral7.
	self assert: result isLiteral.
	self assert: result value = -123
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral8 [
	super testNumberLiteral8.
	self assert: result isLiteral.
	self assert: result value = -123
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testNumberLiteral9 [
	super testNumberLiteral9.
	self assert: result isLiteral.
	self assert: result value = -123.456
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma1 [
	super testPragma1.
	self 
		assert: result pragmas
		format: #('<foo>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma10 [
	super testPragma10.
	self 
		assert: result pragmas
		format: #('<foo: #bar>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma11 [
	super testPragma11.
	self 
		assert: result pragmas
		format: #('<foo: true>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma12 [
	super testPragma12.
	self 
		assert: result pragmas
		format: #('<foo: false>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma13 [
	super testPragma13.
	self 
		assert: result pragmas
		format: #('<foo: nil>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma14 [
	super testPragma14.
	self 
		assert: result pragmas
		format: #('<foo: #()>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma15 [
	super testPragma15.
	self 
		assert: result pragmas
		format: #('<foo: #()>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma2 [
	super testPragma2.
	self 
		assert: result pragmas
		format: #('<foo>' '<bar>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma3 [
	super testPragma3.
	self 
		assert: result pragmas
		format: #('<foo>' ).
	self assert: result body temporaries size = 1.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma4 [
	super testPragma4.
	self 
		assert: result pragmas
		format: #('<foo>' ).
	self assert: result body temporaries size = 1.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma5 [
	super testPragma5.
	self 
		assert: result pragmas
		format: #('<foo>' '<bar>' ).
	self assert: result body temporaries size = 1.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma6 [
	super testPragma6.
	self 
		assert: result pragmas
		format: #('<foo: 1>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma7 [
	super testPragma7.
	self 
		assert: result pragmas
		format: #('<foo: 1.2>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma8 [
	super testPragma8.
	self 
		assert: result pragmas
		format: #('<foo: ''bar''>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-pragmas' }
PPSmalltalkCompilerTests >> testPragma9 [
	super testPragma9.
	self 
		assert: result pragmas
		format: #('<foo: #bar>' ).
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testSequence1 [
	super testSequence1.
	self assert: result isSequence.
	self assert: result temporaries size = 1.
	self assert: result temporaries first isVariable.
	self assert: result temporaries first name = 'a'.
	self assert: result statements size = 2.
	self assert: result statements first isLiteral.
	self assert: result statements first value = 1.
	self assert: result statements second isLiteral.
	self assert: result statements second value = 2
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testSimpleBlock1 [
	super testSimpleBlock1.
	self assert: result isBlock.
	self assert: result arguments isEmpty.
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testSimpleBlock2 [
	super testSimpleBlock2.
	self assert: result isBlock.
	self assert: result arguments isEmpty.
	self assert: result body temporaries isEmpty.
	self assert: result body statements size = 1
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testSimpleBlock3 [
	super testSimpleBlock3.
	self assert: result isBlock.
	self assert: result arguments size = 1.
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testSpecialLiteral1 [
	super testSpecialLiteral1.
	self assert: result isLiteral.
	self assert: result value = true
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testSpecialLiteral2 [
	super testSpecialLiteral2.
	self assert: result isLiteral.
	self assert: result value = false
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testSpecialLiteral3 [
	super testSpecialLiteral3.
	self assert: result isLiteral.
	self assert: result value = nil
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testStatementBlock1 [
	super testStatementBlock1.
	self assert: result isBlock.
	self assert: result arguments isEmpty.
	self assert: result body temporaries isEmpty.
	self assert: result body statements size = 1
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testStatementBlock2 [
	super testStatementBlock2.
	self assert: result isBlock.
	self assert: result arguments isEmpty.
	self assert: result body temporaries size = 1.
	self assert: result body statements size = 1
]

{ #category : #'testing-blocks' }
PPSmalltalkCompilerTests >> testStatementBlock3 [
	super testStatementBlock3.
	self assert: result isBlock.
	self assert: result arguments isEmpty.
	self assert: result body temporaries size = 2.
	self assert: result body statements size = 1
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testStatements1 [
	super testStatements1.
	self assert: result isSequence.
	self assert: result temporaries isEmpty.
	self assert: result statements size = 1.
	self assert: result statements first isLiteral.
	self assert: result statements first value = 1
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testStatements2 [
	super testStatements2.
	self assert: result isSequence.
	self assert: result temporaries isEmpty.
	self assert: result statements size = 2.
	self assert: result statements first isLiteral.
	self assert: result statements first value = 1.
	self assert: result statements second isLiteral.
	self assert: result statements second value = 2
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testStatements3 [
	super testStatements3.
	self assert: result isSequence.
	self assert: result temporaries isEmpty.
	self assert: result statements size = 3.
	self assert: result statements first isLiteral.
	self assert: result statements first value = 1.
	self assert: result statements second isLiteral.
	self assert: result statements second value = 2.
	self assert: result statements third isLiteral.
	self assert: result statements third value = 3
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testStatements4 [
	super testStatements4.
	self assert: result isSequence.
	self assert: result temporaries isEmpty.
	self assert: result statements size = 3.
	self assert: result statements first isLiteral.
	self assert: result statements first value = 1.
	self assert: result statements second isLiteral.
	self assert: result statements second value = 2.
	self assert: result statements third isLiteral.
	self assert: result statements third value = 3
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testStatements5 [
	super testStatements5.
	self assert: result isSequence.
	self assert: result temporaries isEmpty.
	self assert: result statements size = 2.
	self assert: result statements first isLiteral.
	self assert: result statements first value = 1.
	self assert: result statements second isLiteral.
	self assert: result statements second value = 2
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testStringLiteral1 [
	super testStringLiteral1.
	self assert: result isLiteral.
	self assert: result value = ''
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testStringLiteral2 [
	super testStringLiteral2.
	self assert: result isLiteral.
	self assert: result value = 'ab'
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testStringLiteral3 [
	super testStringLiteral3.
	self assert: result isLiteral.
	self assert: result value = 'ab''cd'
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testSymbolLiteral1 [
	super testSymbolLiteral1.
	self assert: result isLiteral.
	self assert: result value = #foo
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testSymbolLiteral2 [
	super testSymbolLiteral2.
	self assert: result isLiteral.
	self assert: result value = #+
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testSymbolLiteral3 [
	super testSymbolLiteral3.
	self assert: result isLiteral.
	self assert: result value = #key:
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testSymbolLiteral4 [
	super testSymbolLiteral4.
	self assert: result isLiteral.
	self assert: result value = #key:value:
]

{ #category : #'testing-literals' }
PPSmalltalkCompilerTests >> testSymbolLiteral5 [
	super testSymbolLiteral5.
	self assert: result isLiteral.
	self assert: result value = #'testing-result'
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testTemporaries1 [
	super testTemporaries1.
	self assert: result isSequence.
	self assert: result temporaries size = 1.
	self assert: result temporaries first isVariable.
	self assert: result temporaries first name = 'a'.
	self assert: result statements isEmpty
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testTemporaries2 [
	super testTemporaries2.
	self assert: result isSequence.
	self assert: result temporaries size = 2.
	self assert: result temporaries first isVariable.
	self assert: result temporaries first name = 'a'.
	self assert: result temporaries second isVariable.
	self assert: result temporaries second name = 'b'.
	self assert: result statements isEmpty
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testTemporaries3 [
	super testTemporaries3.
	self assert: result isSequence.
	self assert: result temporaries size = 3.
	self assert: result temporaries first isVariable.
	self assert: result temporaries first name = 'a'.
	self assert: result temporaries second isVariable.
	self assert: result temporaries second name = 'b'.
	self assert: result temporaries third isVariable.
	self assert: result temporaries third name = 'c'.
	self assert: result statements isEmpty
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testUnaryExpression1 [
	super testUnaryExpression1.
	self assert: result isMessage.
	self assert: result receiver isLiteral.
	self assert: result selector = #abs.
	self assert: result arguments isEmpty
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testUnaryExpression2 [
	super testUnaryExpression2.
	self assert: result isMessage.
	self assert: result receiver isMessage.
	self assert: result receiver receiver isLiteral.
	self assert: result receiver receiver value = 1.
	self assert: result receiver selector = #abs.
	self assert: result receiver arguments isEmpty.
	self assert: result selector = #negated.
	self assert: result arguments isEmpty
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testUnaryMethod1 [
	super testUnaryMethod1.
	self assert: result isMethod.
	self assert: result selector = #abs.
	self assert: result arguments isEmpty.
	self assert: result body temporaries isEmpty.
	self assert: result body statements isEmpty
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testUnaryMethod2 [
	super testUnaryMethod2.
	self assert: result isMethod.
	self assert: result selector = #abs.
	self assert: result arguments isEmpty.
	self assert: result body temporaries size = 1.
	self assert: result body statements isEmpty
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testUnaryMethod3 [
	super testUnaryMethod3.
	self assert: result isMethod.
	self assert: result selector = #abs.
	self assert: result arguments isEmpty.
	self assert: result body temporaries isEmpty.
	self assert: result body statements size = 1
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testUnaryMethod4 [
	super testUnaryMethod4.
	self assert: result isMethod.
	self assert: result selector = #abs.
	self assert: result arguments isEmpty.
	self assert: result body temporaries size = 1.
	self assert: result body statements size = 1
]

{ #category : #'testing-messages' }
PPSmalltalkCompilerTests >> testUnaryMethod5 [
	super testUnaryMethod5.
	self assert: result isMethod.
	self assert: result selector = #abs.
	self assert: result arguments isEmpty.
	self assert: result body temporaries size = 1.
	self assert: result body statements isEmpty
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testVariable1 [
	super testVariable1.
	self assert: result isVariable.
	self assert: result name = 'trueBinding'
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testVariable2 [
	super testVariable2.
	self assert: result isVariable.
	self assert: result name = 'falseBinding'
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testVariable3 [
	super testVariable3.
	self assert: result isVariable.
	self assert: result name = 'nilly'
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testVariable4 [
	super testVariable4.
	self assert: result isVariable.
	self assert: result name = 'selfish'
]

{ #category : #testing }
PPSmalltalkCompilerTests >> testVariable5 [
	super testVariable5.
	self assert: result isVariable.
	self assert: result name = 'supernanny'
]