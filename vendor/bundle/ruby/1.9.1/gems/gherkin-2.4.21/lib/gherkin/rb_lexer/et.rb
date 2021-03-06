
# line 1 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
require 'gherkin/lexer/i18n_lexer'

module Gherkin
  module RbLexer
    class Et #:nodoc:
      
# line 123 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"

 
      def initialize(listener)
        @listener = listener
        
# line 16 "lib/gherkin/rb_lexer/et.rb"
class << self
	attr_accessor :_lexer_actions
	private :_lexer_actions, :_lexer_actions=
end
self._lexer_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 1, 4, 1, 5, 1, 6, 1, 
	7, 1, 8, 1, 9, 1, 10, 1, 
	11, 1, 12, 1, 13, 1, 16, 1, 
	17, 1, 18, 1, 19, 1, 20, 1, 
	21, 1, 22, 1, 23, 2, 2, 18, 
	2, 3, 4, 2, 13, 0, 2, 14, 
	15, 2, 17, 0, 2, 17, 1, 2, 
	17, 16, 2, 17, 19, 2, 18, 6, 
	2, 18, 7, 2, 18, 8, 2, 18, 
	9, 2, 18, 10, 2, 18, 16, 2, 
	20, 21, 2, 22, 0, 2, 22, 1, 
	2, 22, 16, 2, 22, 19, 3, 4, 
	14, 15, 3, 5, 14, 15, 3, 11, 
	14, 15, 3, 12, 14, 15, 3, 13, 
	14, 15, 3, 14, 15, 18, 3, 17, 
	14, 15, 4, 2, 14, 15, 18, 4, 
	3, 4, 14, 15, 4, 17, 0, 14, 
	15
]

class << self
	attr_accessor :_lexer_key_offsets
	private :_lexer_key_offsets, :_lexer_key_offsets=
end
self._lexer_key_offsets = [
	0, 0, 18, 19, 20, 37, 38, 39, 
	41, 43, 48, 53, 58, 63, 67, 71, 
	73, 74, 75, 76, 77, 78, 79, 80, 
	81, 82, 83, 84, 85, 86, 87, 88, 
	89, 90, 92, 97, 104, 109, 110, 111, 
	112, 113, 114, 115, 116, 118, 119, 120, 
	121, 122, 123, 124, 125, 126, 127, 134, 
	136, 138, 140, 142, 144, 146, 163, 164, 
	165, 167, 168, 169, 170, 171, 172, 173, 
	174, 175, 187, 189, 191, 193, 195, 197, 
	199, 201, 203, 205, 207, 209, 211, 213, 
	215, 217, 219, 221, 223, 225, 227, 229, 
	231, 233, 235, 237, 239, 241, 243, 245, 
	247, 249, 251, 253, 255, 257, 259, 261, 
	263, 265, 267, 269, 271, 273, 275, 277, 
	278, 279, 280, 281, 282, 283, 284, 285, 
	286, 287, 288, 289, 290, 291, 292, 293, 
	294, 307, 309, 311, 313, 315, 317, 319, 
	321, 323, 325, 327, 329, 331, 333, 335, 
	337, 339, 341, 343, 345, 347, 349, 351, 
	353, 355, 357, 360, 362, 364, 366, 368, 
	370, 372, 375, 377, 379, 381, 383, 385, 
	387, 389, 391, 393, 395, 397, 398, 399, 
	400, 401, 402, 403, 404, 405, 406, 407, 
	408, 409, 410, 425, 427, 429, 431, 433, 
	435, 437, 439, 441, 443, 445, 447, 449, 
	451, 453, 455, 457, 459, 461, 463, 465, 
	467, 469, 471, 473, 475, 478, 480, 482, 
	484, 486, 488, 490, 492, 494, 496, 498, 
	500, 502, 504, 506, 508, 510, 512, 514, 
	516, 518, 521, 523, 525, 527, 529, 531, 
	532, 533, 534, 535, 536, 537, 538, 552, 
	554, 556, 558, 560, 562, 564, 566, 568, 
	570, 572, 574, 576, 578, 580, 582, 584, 
	586, 588, 590, 592, 594, 596, 598, 600, 
	602, 605, 607, 609, 611, 613, 615, 617, 
	619, 621, 623, 625, 627, 629, 631, 633, 
	635, 637, 639, 641, 643, 645, 648, 650, 
	654, 660, 663, 665, 671, 688
]

class << self
	attr_accessor :_lexer_trans_keys
	private :_lexer_trans_keys, :_lexer_trans_keys=
end
self._lexer_trans_keys = [
	-17, 10, 32, 34, 35, 37, 42, 64, 
	69, 74, 75, 79, 82, 83, 84, 124, 
	9, 13, -69, -65, 10, 32, 34, 35, 
	37, 42, 64, 69, 74, 75, 79, 82, 
	83, 84, 124, 9, 13, 34, 34, 10, 
	13, 10, 13, 10, 32, 34, 9, 13, 
	10, 32, 34, 9, 13, 10, 32, 34, 
	9, 13, 10, 32, 34, 9, 13, 10, 
	32, 9, 13, 10, 32, 9, 13, 10, 
	13, 10, 95, 70, 69, 65, 84, 85, 
	82, 69, 95, 69, 78, 68, 95, 37, 
	32, 10, 10, 13, 13, 32, 64, 9, 
	10, 9, 10, 13, 32, 64, 11, 12, 
	10, 32, 64, 9, 13, 101, 108, 100, 
	97, 100, 101, 115, 97, 117, 104, 116, 
	117, 109, 105, 100, 58, 10, 10, 10, 
	32, 35, 79, 124, 9, 13, 10, 109, 
	10, 97, 10, 100, 10, 117, 10, 115, 
	10, 58, 10, 32, 34, 35, 37, 42, 
	64, 69, 74, 75, 79, 82, 83, 84, 
	124, 9, 13, 117, 105, 32, 100, 109, 
	97, 100, 117, 115, 58, 10, 10, 10, 
	32, 35, 37, 64, 74, 79, 82, 83, 
	84, 9, 13, 10, 95, 10, 70, 10, 
	69, 10, 65, 10, 84, 10, 85, 10, 
	82, 10, 69, 10, 95, 10, 69, 10, 
	78, 10, 68, 10, 95, 10, 37, 10, 
	117, 10, 104, 10, 116, 10, 117, 10, 
	109, 10, 105, 10, 100, 10, 58, 10, 
	109, 10, 97, 10, 100, 10, 117, 10, 
	115, 10, 97, 10, 97, 10, 109, 10, 
	115, 10, 116, 10, 115, 10, 101, 10, 
	110, 10, 97, 10, 97, 10, 114, 10, 
	105, 10, 117, 10, 109, 10, 97, 10, 
	117, 10, 115, 10, 116, 97, 97, 109, 
	115, 116, 115, 101, 110, 97, 97, 114, 
	105, 117, 109, 58, 10, 10, 10, 32, 
	35, 37, 42, 64, 69, 74, 75, 79, 
	83, 9, 13, 10, 95, 10, 70, 10, 
	69, 10, 65, 10, 84, 10, 85, 10, 
	82, 10, 69, 10, 95, 10, 69, 10, 
	78, 10, 68, 10, 95, 10, 37, 10, 
	32, 10, 101, 10, 108, 10, 100, 10, 
	97, 10, 100, 10, 101, 10, 115, 10, 
	97, 10, 117, 10, 105, 10, 32, 100, 
	10, 109, 10, 97, 10, 100, 10, 117, 
	10, 115, 10, 58, 10, 105, 116, 10, 
	105, 10, 115, 10, 101, 10, 110, 10, 
	97, 10, 97, 10, 114, 10, 105, 10, 
	117, 10, 109, 105, 116, 105, 115, 101, 
	110, 97, 97, 114, 105, 117, 109, 58, 
	10, 10, 10, 32, 35, 37, 42, 64, 
	69, 74, 75, 79, 82, 83, 84, 9, 
	13, 10, 95, 10, 70, 10, 69, 10, 
	65, 10, 84, 10, 85, 10, 82, 10, 
	69, 10, 95, 10, 69, 10, 78, 10, 
	68, 10, 95, 10, 37, 10, 32, 10, 
	101, 10, 108, 10, 100, 10, 97, 10, 
	100, 10, 101, 10, 115, 10, 97, 10, 
	117, 10, 105, 10, 32, 100, 10, 109, 
	10, 97, 10, 100, 10, 117, 10, 115, 
	10, 58, 10, 97, 10, 97, 10, 109, 
	10, 115, 10, 116, 10, 115, 10, 101, 
	10, 110, 10, 97, 10, 97, 10, 114, 
	10, 105, 10, 117, 10, 109, 10, 105, 
	116, 10, 105, 10, 97, 10, 117, 10, 
	115, 10, 116, 97, 117, 115, 116, 58, 
	10, 10, 10, 32, 35, 37, 42, 64, 
	69, 74, 75, 79, 82, 83, 9, 13, 
	10, 95, 10, 70, 10, 69, 10, 65, 
	10, 84, 10, 85, 10, 82, 10, 69, 
	10, 95, 10, 69, 10, 78, 10, 68, 
	10, 95, 10, 37, 10, 32, 10, 101, 
	10, 108, 10, 100, 10, 97, 10, 100, 
	10, 101, 10, 115, 10, 97, 10, 117, 
	10, 105, 10, 32, 100, 10, 109, 10, 
	97, 10, 100, 10, 117, 10, 115, 10, 
	58, 10, 97, 10, 97, 10, 109, 10, 
	115, 10, 116, 10, 115, 10, 101, 10, 
	110, 10, 97, 10, 97, 10, 114, 10, 
	105, 10, 117, 10, 109, 10, 105, 116, 
	10, 105, 32, 124, 9, 13, 10, 32, 
	92, 124, 9, 13, 10, 92, 124, 10, 
	92, 10, 32, 92, 124, 9, 13, 10, 
	32, 34, 35, 37, 42, 64, 69, 74, 
	75, 79, 82, 83, 84, 124, 9, 13, 
	0
]

class << self
	attr_accessor :_lexer_single_lengths
	private :_lexer_single_lengths, :_lexer_single_lengths=
end
self._lexer_single_lengths = [
	0, 16, 1, 1, 15, 1, 1, 2, 
	2, 3, 3, 3, 3, 2, 2, 2, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 2, 3, 5, 3, 1, 1, 1, 
	1, 1, 1, 1, 2, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 5, 2, 
	2, 2, 2, 2, 2, 15, 1, 1, 
	2, 1, 1, 1, 1, 1, 1, 1, 
	1, 10, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	11, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 3, 2, 2, 2, 2, 2, 
	2, 3, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 13, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 3, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 3, 2, 2, 2, 2, 2, 1, 
	1, 1, 1, 1, 1, 1, 12, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	3, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 3, 2, 2, 
	4, 3, 2, 4, 15, 0
]

class << self
	attr_accessor :_lexer_range_lengths
	private :_lexer_range_lengths, :_lexer_range_lengths=
end
self._lexer_range_lengths = [
	0, 1, 0, 0, 1, 0, 0, 0, 
	0, 1, 1, 1, 1, 1, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 1, 1, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	1, 0, 0, 1, 1, 0
]

class << self
	attr_accessor :_lexer_index_offsets
	private :_lexer_index_offsets, :_lexer_index_offsets=
end
self._lexer_index_offsets = [
	0, 0, 18, 20, 22, 39, 41, 43, 
	46, 49, 54, 59, 64, 69, 73, 77, 
	80, 82, 84, 86, 88, 90, 92, 94, 
	96, 98, 100, 102, 104, 106, 108, 110, 
	112, 114, 117, 122, 129, 134, 136, 138, 
	140, 142, 144, 146, 148, 151, 153, 155, 
	157, 159, 161, 163, 165, 167, 169, 176, 
	179, 182, 185, 188, 191, 194, 211, 213, 
	215, 218, 220, 222, 224, 226, 228, 230, 
	232, 234, 246, 249, 252, 255, 258, 261, 
	264, 267, 270, 273, 276, 279, 282, 285, 
	288, 291, 294, 297, 300, 303, 306, 309, 
	312, 315, 318, 321, 324, 327, 330, 333, 
	336, 339, 342, 345, 348, 351, 354, 357, 
	360, 363, 366, 369, 372, 375, 378, 381, 
	383, 385, 387, 389, 391, 393, 395, 397, 
	399, 401, 403, 405, 407, 409, 411, 413, 
	415, 428, 431, 434, 437, 440, 443, 446, 
	449, 452, 455, 458, 461, 464, 467, 470, 
	473, 476, 479, 482, 485, 488, 491, 494, 
	497, 500, 503, 507, 510, 513, 516, 519, 
	522, 525, 529, 532, 535, 538, 541, 544, 
	547, 550, 553, 556, 559, 562, 564, 566, 
	568, 570, 572, 574, 576, 578, 580, 582, 
	584, 586, 588, 603, 606, 609, 612, 615, 
	618, 621, 624, 627, 630, 633, 636, 639, 
	642, 645, 648, 651, 654, 657, 660, 663, 
	666, 669, 672, 675, 678, 682, 685, 688, 
	691, 694, 697, 700, 703, 706, 709, 712, 
	715, 718, 721, 724, 727, 730, 733, 736, 
	739, 742, 746, 749, 752, 755, 758, 761, 
	763, 765, 767, 769, 771, 773, 775, 789, 
	792, 795, 798, 801, 804, 807, 810, 813, 
	816, 819, 822, 825, 828, 831, 834, 837, 
	840, 843, 846, 849, 852, 855, 858, 861, 
	864, 868, 871, 874, 877, 880, 883, 886, 
	889, 892, 895, 898, 901, 904, 907, 910, 
	913, 916, 919, 922, 925, 928, 932, 935, 
	939, 945, 949, 952, 958, 975
]

class << self
	attr_accessor :_lexer_indicies
	private :_lexer_indicies, :_lexer_indicies=
end
self._lexer_indicies = [
	1, 3, 2, 4, 5, 6, 7, 8, 
	9, 10, 11, 12, 13, 14, 15, 16, 
	2, 0, 17, 0, 2, 0, 3, 2, 
	4, 5, 6, 7, 8, 9, 10, 11, 
	12, 13, 14, 15, 16, 2, 0, 18, 
	0, 19, 0, 21, 22, 20, 24, 25, 
	23, 28, 27, 29, 27, 26, 32, 31, 
	33, 31, 30, 32, 31, 34, 31, 30, 
	32, 31, 35, 31, 30, 37, 36, 36, 
	0, 3, 38, 38, 0, 40, 41, 39, 
	3, 0, 42, 0, 43, 0, 44, 0, 
	45, 0, 46, 0, 47, 0, 48, 0, 
	49, 0, 50, 0, 51, 0, 52, 0, 
	53, 0, 54, 0, 55, 0, 56, 0, 
	0, 57, 59, 60, 58, 0, 0, 0, 
	0, 61, 62, 63, 62, 62, 65, 64, 
	61, 3, 66, 8, 66, 0, 67, 0, 
	68, 0, 69, 0, 70, 0, 71, 0, 
	72, 0, 73, 0, 73, 74, 0, 75, 
	0, 76, 0, 77, 0, 78, 0, 79, 
	0, 80, 0, 81, 0, 83, 82, 85, 
	84, 85, 86, 87, 88, 87, 86, 84, 
	85, 89, 84, 85, 90, 84, 85, 91, 
	84, 85, 92, 84, 85, 93, 84, 85, 
	94, 84, 96, 95, 97, 98, 99, 100, 
	101, 102, 103, 104, 105, 106, 107, 108, 
	109, 95, 0, 110, 0, 111, 0, 56, 
	73, 0, 112, 0, 113, 0, 114, 0, 
	115, 0, 116, 0, 117, 0, 119, 118, 
	121, 120, 121, 122, 123, 124, 123, 125, 
	126, 127, 128, 129, 122, 120, 121, 130, 
	120, 121, 131, 120, 121, 132, 120, 121, 
	133, 120, 121, 134, 120, 121, 135, 120, 
	121, 136, 120, 121, 137, 120, 121, 138, 
	120, 121, 139, 120, 121, 140, 120, 121, 
	141, 120, 121, 142, 120, 121, 143, 120, 
	121, 144, 120, 121, 145, 120, 121, 146, 
	120, 121, 147, 120, 121, 148, 120, 121, 
	149, 120, 121, 150, 120, 121, 151, 120, 
	121, 152, 120, 121, 153, 120, 121, 154, 
	120, 121, 155, 120, 121, 150, 120, 121, 
	156, 120, 121, 157, 120, 121, 158, 120, 
	121, 159, 120, 121, 160, 120, 121, 161, 
	120, 121, 162, 120, 121, 163, 120, 121, 
	164, 120, 121, 165, 120, 121, 166, 120, 
	121, 167, 120, 121, 168, 120, 121, 150, 
	120, 121, 169, 120, 121, 170, 120, 121, 
	171, 120, 121, 150, 120, 172, 0, 173, 
	0, 174, 0, 175, 0, 176, 0, 177, 
	0, 178, 0, 179, 0, 180, 0, 181, 
	0, 182, 0, 183, 0, 184, 0, 185, 
	0, 186, 0, 188, 187, 190, 189, 190, 
	191, 192, 193, 194, 192, 195, 196, 197, 
	198, 199, 191, 189, 190, 200, 189, 190, 
	201, 189, 190, 202, 189, 190, 203, 189, 
	190, 204, 189, 190, 205, 189, 190, 206, 
	189, 190, 207, 189, 190, 208, 189, 190, 
	209, 189, 190, 210, 189, 190, 211, 189, 
	190, 212, 189, 190, 213, 189, 190, 214, 
	189, 190, 215, 189, 190, 216, 189, 190, 
	217, 189, 190, 218, 189, 190, 219, 189, 
	190, 220, 189, 190, 221, 189, 190, 221, 
	189, 190, 222, 189, 190, 223, 189, 190, 
	214, 221, 189, 190, 224, 189, 190, 225, 
	189, 190, 226, 189, 190, 227, 189, 190, 
	228, 189, 190, 214, 189, 190, 229, 230, 
	189, 190, 220, 189, 190, 231, 189, 190, 
	232, 189, 190, 233, 189, 190, 234, 189, 
	190, 235, 189, 190, 236, 189, 190, 237, 
	189, 190, 238, 189, 190, 228, 189, 239, 
	240, 0, 72, 0, 241, 0, 242, 0, 
	243, 0, 244, 0, 245, 0, 246, 0, 
	247, 0, 248, 0, 249, 0, 250, 0, 
	252, 251, 254, 253, 254, 255, 256, 257, 
	258, 256, 259, 260, 261, 262, 263, 264, 
	265, 255, 253, 254, 266, 253, 254, 267, 
	253, 254, 268, 253, 254, 269, 253, 254, 
	270, 253, 254, 271, 253, 254, 272, 253, 
	254, 273, 253, 254, 274, 253, 254, 275, 
	253, 254, 276, 253, 254, 277, 253, 254, 
	278, 253, 254, 279, 253, 254, 280, 253, 
	254, 281, 253, 254, 282, 253, 254, 283, 
	253, 254, 284, 253, 254, 285, 253, 254, 
	286, 253, 254, 287, 253, 254, 287, 253, 
	254, 288, 253, 254, 289, 253, 254, 280, 
	287, 253, 254, 290, 253, 254, 291, 253, 
	254, 292, 253, 254, 293, 253, 254, 294, 
	253, 254, 280, 253, 254, 295, 253, 254, 
	296, 253, 254, 297, 253, 254, 298, 253, 
	254, 299, 253, 254, 300, 253, 254, 301, 
	253, 254, 302, 253, 254, 303, 253, 254, 
	304, 253, 254, 305, 253, 254, 306, 253, 
	254, 307, 253, 254, 294, 253, 254, 308, 
	299, 253, 254, 286, 253, 254, 309, 253, 
	254, 310, 253, 254, 311, 253, 254, 294, 
	253, 312, 0, 313, 0, 314, 0, 315, 
	0, 316, 0, 318, 317, 320, 319, 320, 
	321, 322, 323, 324, 322, 325, 326, 327, 
	328, 329, 330, 321, 319, 320, 331, 319, 
	320, 332, 319, 320, 333, 319, 320, 334, 
	319, 320, 335, 319, 320, 336, 319, 320, 
	337, 319, 320, 338, 319, 320, 339, 319, 
	320, 340, 319, 320, 341, 319, 320, 342, 
	319, 320, 343, 319, 320, 344, 319, 320, 
	345, 319, 320, 346, 319, 320, 347, 319, 
	320, 348, 319, 320, 349, 319, 320, 350, 
	319, 320, 351, 319, 320, 352, 319, 320, 
	352, 319, 320, 353, 319, 320, 354, 319, 
	320, 345, 352, 319, 320, 355, 319, 320, 
	356, 319, 320, 357, 319, 320, 358, 319, 
	320, 359, 319, 320, 345, 319, 320, 360, 
	319, 320, 361, 319, 320, 362, 319, 320, 
	363, 319, 320, 364, 319, 320, 365, 319, 
	320, 366, 319, 320, 367, 319, 320, 368, 
	319, 320, 369, 319, 320, 370, 319, 320, 
	371, 319, 320, 372, 319, 320, 359, 319, 
	320, 373, 364, 319, 320, 351, 319, 374, 
	375, 374, 0, 378, 377, 379, 380, 377, 
	376, 0, 382, 383, 381, 0, 382, 381, 
	378, 384, 382, 383, 384, 381, 378, 385, 
	386, 387, 388, 389, 390, 391, 392, 393, 
	394, 395, 396, 397, 398, 385, 0, 399, 
	0
]

class << self
	attr_accessor :_lexer_trans_targs
	private :_lexer_trans_targs, :_lexer_trans_targs=
end
self._lexer_trans_targs = [
	0, 2, 4, 4, 5, 15, 17, 31, 
	34, 37, 44, 62, 65, 119, 180, 247, 
	303, 3, 6, 7, 8, 9, 8, 8, 
	9, 8, 10, 10, 10, 11, 10, 10, 
	10, 11, 12, 13, 14, 4, 14, 15, 
	4, 16, 18, 19, 20, 21, 22, 23, 
	24, 25, 26, 27, 28, 29, 30, 309, 
	32, 33, 33, 4, 16, 35, 36, 4, 
	35, 34, 36, 38, 39, 40, 41, 42, 
	43, 31, 45, 46, 47, 48, 49, 50, 
	51, 52, 53, 54, 53, 54, 54, 4, 
	55, 56, 57, 58, 59, 60, 61, 4, 
	4, 5, 15, 17, 31, 34, 37, 44, 
	62, 65, 119, 180, 247, 303, 63, 64, 
	66, 67, 68, 69, 70, 71, 72, 73, 
	72, 73, 73, 4, 74, 88, 96, 101, 
	105, 115, 75, 76, 77, 78, 79, 80, 
	81, 82, 83, 84, 85, 86, 87, 4, 
	89, 90, 91, 92, 93, 94, 95, 61, 
	97, 98, 99, 100, 102, 103, 104, 105, 
	106, 107, 108, 109, 110, 111, 112, 113, 
	114, 116, 117, 118, 120, 121, 122, 123, 
	124, 125, 126, 127, 128, 129, 130, 131, 
	132, 133, 134, 135, 136, 135, 136, 136, 
	4, 137, 151, 152, 159, 160, 163, 169, 
	138, 139, 140, 141, 142, 143, 144, 145, 
	146, 147, 148, 149, 150, 4, 61, 153, 
	154, 155, 156, 157, 158, 151, 161, 162, 
	164, 165, 166, 167, 168, 170, 171, 172, 
	173, 174, 175, 176, 177, 178, 179, 181, 
	182, 183, 184, 185, 186, 187, 188, 189, 
	190, 191, 192, 193, 194, 193, 194, 194, 
	4, 195, 209, 210, 217, 218, 221, 227, 
	241, 243, 196, 197, 198, 199, 200, 201, 
	202, 203, 204, 205, 206, 207, 208, 4, 
	61, 211, 212, 213, 214, 215, 216, 209, 
	219, 220, 222, 223, 224, 225, 226, 228, 
	229, 230, 231, 232, 233, 234, 235, 236, 
	237, 238, 239, 240, 242, 244, 245, 246, 
	248, 249, 250, 251, 252, 253, 254, 253, 
	254, 254, 4, 255, 269, 270, 277, 278, 
	281, 287, 301, 256, 257, 258, 259, 260, 
	261, 262, 263, 264, 265, 266, 267, 268, 
	4, 61, 271, 272, 273, 274, 275, 276, 
	269, 279, 280, 282, 283, 284, 285, 286, 
	288, 289, 290, 291, 292, 293, 294, 295, 
	296, 297, 298, 299, 300, 302, 303, 304, 
	305, 307, 308, 306, 304, 305, 306, 304, 
	307, 308, 5, 15, 17, 31, 34, 37, 
	44, 62, 65, 119, 180, 247, 303, 0
]

class << self
	attr_accessor :_lexer_trans_actions
	private :_lexer_trans_actions, :_lexer_trans_actions=
end
self._lexer_trans_actions = [
	43, 0, 0, 54, 3, 1, 0, 29, 
	1, 29, 29, 29, 29, 29, 29, 29, 
	35, 0, 0, 0, 7, 135, 48, 0, 
	102, 9, 5, 45, 130, 45, 0, 33, 
	122, 33, 33, 0, 11, 106, 0, 0, 
	114, 25, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 57, 0, 110, 23, 0, 27, 118, 
	27, 51, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 57, 140, 0, 54, 0, 81, 
	84, 0, 0, 0, 0, 0, 21, 31, 
	126, 60, 57, 31, 63, 57, 63, 63, 
	63, 63, 63, 63, 63, 66, 0, 0, 
	0, 0, 0, 0, 0, 0, 57, 140, 
	0, 54, 0, 69, 33, 84, 84, 84, 
	84, 84, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 13, 
	0, 0, 0, 0, 0, 0, 0, 13, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 57, 140, 0, 54, 0, 
	78, 33, 84, 84, 84, 84, 84, 84, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 19, 19, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 57, 140, 0, 54, 0, 
	75, 33, 84, 84, 84, 84, 84, 84, 
	84, 84, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 17, 
	17, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 57, 140, 0, 
	54, 0, 72, 33, 84, 84, 84, 84, 
	84, 84, 84, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	15, 15, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	37, 37, 54, 37, 87, 0, 0, 39, 
	0, 0, 93, 90, 41, 96, 90, 96, 
	96, 96, 96, 96, 96, 96, 99, 0
]

class << self
	attr_accessor :_lexer_eof_actions
	private :_lexer_eof_actions, :_lexer_eof_actions=
end
self._lexer_eof_actions = [
	0, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43, 43, 43, 
	43, 43, 43, 43, 43, 43
]

class << self
	attr_accessor :lexer_start
end
self.lexer_start = 1;
class << self
	attr_accessor :lexer_first_final
end
self.lexer_first_final = 309;
class << self
	attr_accessor :lexer_error
end
self.lexer_error = 0;

class << self
	attr_accessor :lexer_en_main
end
self.lexer_en_main = 1;


# line 128 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
      end
 
      def scan(data)
        data = (data + "\n%_FEATURE_END_%").unpack("c*") # Explicit EOF simplifies things considerably
        eof = pe = data.length
 
        @line_number = 1
        @last_newline = 0
 
        
# line 641 "lib/gherkin/rb_lexer/et.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = lexer_start
end

# line 138 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
        
# line 650 "lib/gherkin/rb_lexer/et.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _lexer_key_offsets[cs]
	_trans = _lexer_index_offsets[cs]
	_klen = _lexer_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p] < _lexer_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p] > _lexer_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _lexer_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p] < _lexer_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p] > _lexer_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _lexer_indicies[_trans]
	cs = _lexer_trans_targs[_trans]
	if _lexer_trans_actions[_trans] != 0
		_acts = _lexer_trans_actions[_trans]
		_nacts = _lexer_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _lexer_actions[_acts - 1]
when 0 then
# line 9 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @content_start = p
          @current_line = @line_number
          @start_col = p - @last_newline - "#{@keyword}:".length
        		end
when 1 then
# line 15 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @current_line = @line_number
          @start_col = p - @last_newline
        		end
when 2 then
# line 20 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @content_start = p
        		end
when 3 then
# line 24 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @docstring_content_type_start = p
        		end
when 4 then
# line 27 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @docstring_content_type_end = p
        		end
when 5 then
# line 31 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          con = unindent(@start_col, utf8_pack(data[@content_start...@next_keyword_start-1]).sub(/(\r?\n)?([\t ])*\Z/, '').gsub(/\\"\\"\\"/, '"""'))
          con_type = utf8_pack(data[@docstring_content_type_start...@docstring_content_type_end]).strip
          @listener.doc_string(con_type, con, @current_line) 
        		end
when 6 then
# line 36 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          p = store_keyword_content(:feature, data, p, eof)
        		end
when 7 then
# line 40 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          p = store_keyword_content(:background, data, p, eof)
        		end
when 8 then
# line 44 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          p = store_keyword_content(:scenario, data, p, eof)
        		end
when 9 then
# line 48 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          p = store_keyword_content(:scenario_outline, data, p, eof)
        		end
when 10 then
# line 52 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          p = store_keyword_content(:examples, data, p, eof)
        		end
when 11 then
# line 56 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          @listener.step(@keyword, con, @current_line)
        		end
when 12 then
# line 61 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          @listener.comment(con, @line_number)
          @keyword_start = nil
        		end
when 13 then
# line 67 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          @listener.tag(con, @current_line)
          @keyword_start = nil
        		end
when 14 then
# line 73 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @line_number += 1
        		end
when 15 then
# line 77 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @last_newline = p + 1
        		end
when 16 then
# line 81 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @keyword_start ||= p
        		end
when 17 then
# line 85 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @keyword = utf8_pack(data[@keyword_start...p]).sub(/:$/,'')
          @keyword_start = nil
        		end
when 18 then
# line 90 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @next_keyword_start = p
        		end
when 19 then
# line 94 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          p = p - 1
          current_row = []
          @current_line = @line_number
        		end
when 20 then
# line 100 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @content_start = p
        		end
when 21 then
# line 104 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          con = utf8_pack(data[@content_start...p]).strip
          current_row << con.gsub(/\\\|/, "|").gsub(/\\n/, "\n").gsub(/\\\\/, "\\")
        		end
when 22 then
# line 109 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          @listener.row(current_row, @current_line)
        		end
when 23 then
# line 113 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          if cs < lexer_first_final
            content = current_line_content(data, p)
            raise Gherkin::Lexer::LexingError.new("Lexing error on line %d: '%s'. See http://wiki.github.com/cucumber/gherkin/lexingerror for more information." % [@line_number, content])
          else
            @listener.eof
          end
        		end
# line 894 "lib/gherkin/rb_lexer/et.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	__acts = _lexer_eof_actions[cs]
	__nacts =  _lexer_actions[__acts]
	__acts += 1
	while __nacts > 0
		__nacts -= 1
		__acts += 1
		case _lexer_actions[__acts - 1]
when 23 then
# line 113 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
		begin

          if cs < lexer_first_final
            content = current_line_content(data, p)
            raise Gherkin::Lexer::LexingError.new("Lexing error on line %d: '%s'. See http://wiki.github.com/cucumber/gherkin/lexingerror for more information." % [@line_number, content])
          else
            @listener.eof
          end
        		end
# line 933 "lib/gherkin/rb_lexer/et.rb"
		end # eof action switch
	end
	if _trigger_goto
		next
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 139 "/Users/ahellesoy/scm/gherkin/tasks/../ragel/i18n/et.rb.rl"
      end

      def unindent(startcol, text)
        text.gsub(/^[\t ]{0,#{startcol}}/, "")
      end

      def store_keyword_content(event, data, p, eof)
        end_point = (!@next_keyword_start or (p == eof)) ? p : @next_keyword_start
        content = unindent(@start_col + 2, utf8_pack(data[@content_start...end_point])).rstrip
        content_lines = content.split("\n")
        name = content_lines.shift || ""
        name.strip!
        description = content_lines.join("\n")
        @listener.__send__(event, @keyword, name, description, @current_line)
        @next_keyword_start ? @next_keyword_start - 1 : p
      ensure
        @next_keyword_start = nil
      end
      
      def current_line_content(data, p)
        rest = data[@last_newline..-1]
        utf8_pack(rest[0..rest.index(10)||-1]).strip # 10 is \n
      end

      if (RUBY_VERSION =~ /^1\.9/)
        def utf8_pack(array)
          array.pack("c*").force_encoding("UTF-8")
        end
      else
        def utf8_pack(array)
          array.pack("c*")
        end
      end
    end
  end
end
