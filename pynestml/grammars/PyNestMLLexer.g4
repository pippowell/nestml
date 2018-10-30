/*
 *  Tokens.g4
 *
 *  This file is part of NEST.
 *
 *  Copyright (C) 2004 The NEST Initiative
 *
 *  NEST is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  NEST is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with NEST.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

lexer grammar PyNestMLLexer;

  // N.B. the zeroth channel is the normal channel, the first is HIDDEN, so COMMENT=2 and NEW_LINE=3
  channels {COMMENT, NEW_LINE}


  SL_COMMENT: ('#' (~('\n' |'\r' ))*) -> channel(2);

  ML_COMMENT : ('/*' .*? '*/' | '"""' .*? '"""')-> channel(2);

  NEWLINE : ('\r' '\n' | '\r' | '\n' ) -> channel(3);

  WS : (' ' | '\t')->channel(1);

  // this token enables an expression that stretches over multiple lines. The first line ends with a `\` character
  LINE_ESCAPE : '\\' '\r'? '\n'->channel(1);

  /**
  * Symbols and literals are parsed first
  *
  * Magic (@) keywords are defined with their @-symbol in front, because otherwise they would preclude the user from defining variables named "delay". (Rules are matched in the order in which they appear, and NAME appears below MAGIC_KEYWORD_DELAY).
  */

  END_KEYWORD : 'end';
  INTEGER_KEYWORD : 'integer';
  REAL_KEYWORD : 'real';
  STRING_KEYWORD : 'string';
  BOOLEAN_KEYWORD : 'boolean';
  VOID_KEYWORD : 'void';  
  FUNCTION_KEYWORD : 'function';
  RETURN_KEYWORD : 'return';
  IF_KEYWORD : 'if';
  ELIF_KEYWORD : 'elif';
  ELSE_KEYWORD : 'else';
  FOR_KEYWORD : 'for';
  WHILE_KEYWORD : 'while';
  IN_KEYWORD : 'in';
  STEP_KEYWORD : 'step';
  INF_KEYWORD : 'inf';
  AND_KEYWORD : 'and';
  OR_KEYWORD : 'or';
  NOT_KEYWORD : 'not';
  
  RECORDABLE_KEYWORD : 'recordable';
  SHAPE_KEYWORD : 'shape';
  NEURON_KEYWORD : 'neuron';
  SYNAPSE_KEYWORD : 'synapse';
  STATE_KEYWORD : 'state';
  PARAMETERS_KEYWORD : 'parameters';
  INTERNALS_KEYWORD : 'internals';
  INITIAL_VALUES_KEYWORD : 'initial_values';
  UPDATE_KEYWORD : 'update';
  EQUATIONS_KEYWORD : 'equations';
  INPUT_KEYWORD : 'input';
  OUTPUT_KEYWORD : 'output';
  CURRENT_KEYWORD : 'current';
  SPIKE_KEYWORD : 'spike';
  INHIBITORY_KEYWORD : 'inhibitory';
  EXCITATORY_KEYWORD : 'excitatory';

  MAGIC_KEYWORD_HOMOGENEOUS : '@homogeneous';
  MAGIC_KEYWORD_HETEROGENEOUS : '@heterogeneous';
  MAGIC_KEYWORD_WEIGHT : '@weight';
  MAGIC_KEYWORD_DELAY : '@delay';

  ELLIPSIS : '...';
  LEFT_PAREN : '(';
  RIGHT_PAREN : ')';
  PLUS : '+';
  TILDE : '~';
  PIPE : '|';
  CARET : '^';
  AMPERSAND : '&';
  LEFT_SQUARE_BRACKET : '[';
  LEFT_ANGLE_MINUS : '<-';
  RIGHT_SQUARE_BRACKET : ']';
  LEFT_LEFT_SQUARE : '[[';
  RIGHT_RIGHT_SQUARE : ']]';
  LEFT_LEFT_ANGLE : '<<';
  RIGHT_RIGHT_ANGLE : '>>';
  LEFT_ANGLE : '<';
  RIGHT_ANGLE : '>';
  LEFT_ANGLE_EQUALS : '<=';
  PLUS_EQUALS : '+=';
  MINUS_EQUALS : '-=';
  STAR_EQUALS : '*=';
  FORWARD_SLASH_EQUALS : '/=';
  EQUALS_EQUALS : '==';
  EXCLAMATION_EQUALS : '!=';
  LEFT_ANGLE_RIGHT_ANGLE : '<>';
  RIGHT_ANGLE_EQUALS : '>=';
  COMMA : ',';
  MINUS : '-';
  EQUALS : '=';
  STAR : '*';
  STAR_STAR : '**';
  FORWARD_SLASH : '/';
  PERCENT : '%';
  QUESTION : '?';
  COLON : ':';
  SEMICOLON : ';';


  /**
  * Boolean values, i.e., true and false, should be handled as tokens in order to enable handling of lower
  * and upper case definitions. Here, we allow both concepts, the python like syntax starting with upper case and
  * the concept as currently used in NESTML with the lower case.
  */
  BOOLEAN_LITERAL : 'true' | 'True' | 'false' | 'False' ;

  /**
  * String literals are always enclosed in "...".
  */

  STRING_LITERAL : '"' ( [a-zA-Z] | '_' | '$' )( [a-zA-Z] | '_' | [0-9] | '$' )* '"';

  NAME : ( [a-zA-Z] | '_' | '$' )( [a-zA-Z] | '_' | [0-9] | '$' )*;

  /**
  * Numeric literals. We allow integers as well as floats. Moreover, we ensure that values are either == 0 or
  * do not start with 0, e.g., 01221.012, where the leading 0 does not make sense.
  * Examples:
  *  (1) 1 -> integer
  *  (2) 3.14 -> float
  *  (3) 10E10 -> float with exponent
  */
  INTEGER : NON_ZERO_INTEGER
          | '0';

  DIFFERENTIAL_ORDER : '\'';

  fragment NON_ZERO_INTEGER : [1-9][0-9]*;

  /**
  * The following declaration originates from Antrl4 Python Grammar definition as distributed under the MIT license.
  * link: https://github.com/antlr/grammars-v4/blob/master/python3/Python3.g4
  */

  /*
  * A float can be a point float, e.g., 10.05 or 0.1, or an exponent float, e.g. 10E10.
  */
  FLOAT : POINT_FLOAT | EXPONENT_FLOAT;

  fragment POINT_FLOAT : (NON_ZERO_INTEGER |'0')? FRACTION
                       | (NON_ZERO_INTEGER |'0') '.'
                       ;

  fragment EXPONENT_FLOAT: ( NON_ZERO_INTEGER | POINT_FLOAT ) EXPONENT ;

  /**
  * The exponent is introduced by e or E, the signum and an integer.
  */
  fragment EXPONENT: [eE] [+-]? (NON_ZERO_INTEGER |'0');

  fragment FRACTION: '.' [0-9]+;
