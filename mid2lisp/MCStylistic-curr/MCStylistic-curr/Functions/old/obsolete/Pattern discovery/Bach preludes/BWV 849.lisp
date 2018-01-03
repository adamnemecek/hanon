#| Tom Collins
   Monday 8 February 2010
   Completed Wednesday 10 February 2010 |#

#| The purpose is to create a vector representation
of Bach's Prelude in C# Minor, BWV 849.

; REQUIRED PACAKGES
; (in-package :common-lisp-user)
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/list-processing.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/midi-save.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/Maths foundation"
  "/set-operations.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/text-files.lisp"))
(load
 (concatenate
  'string
  "/Applications/CCL/Lisp code/File conversion"
  "/director-musices.lisp"))

(director-musices2dataset
 (concatenate
  'string
  "/Users/tec69/Open/Potential thesis chapters"
  "/Exhaustive algorithms for discovering exact "
  "translational patterns in Scarlatti's "
  "keyboard sonatas/Director musices/BWV 849.txt"))
|#

(progn
  (setq
   dataset
   '(
     #|1|#
     (0 49 53 12 0) (0 68 64 1/2 3)
     (1/2 66 63 1/2 3) (1 64 62 1/2 3)
     (3/2 63 61 1/2 3) (2 64 62 1/2 3)
     (5/2 61 60 1/2 3) (3 64 62 2 2) (3 68 64 2 2)
     (3 73 67 3/2 3) (9/2 71 66 1/2 3) (5 66 63 1 2)
     (5 69 65 1 3)
     #|2|#
     (6 56 57 1/2 1) (6 64 62 5 2) (6 68 64 5 3)
     (13/2 54 56 1/2 1) (7 52 55 1/2 1)
     (15/2 51 54 1/2 1) (8 52 55 1/2 1)
     (17/2 49 53 1/2 1) (9 61 60 3/2 1)
     (21/2 59 59 1/2 1) (11 57 58 1 1)
     (11 66 63 1 3) (11 66 63 4 2)
     #|3|#
     (12 48 52 5 0) (12 56 57 5 1) (12 75 68 1/2 3)
     (25/2 73 67 1/2 3) (13 72 66 1/2 3)
     (27/2 70 65 1/2 3) (14 72 66 1/2 3)
     (29/2 68 64 1/2 3) (15 68 64 2 2)
     (15 75 68 2 2) (15 80 71 3/2 3)
     (33/2 78 70 1/2 3) (17 49 53 1 0)
     (17 61 60 1 1) (17 68 64 1 2) (17 73 67 1 2)
     (17 76 69 1 3)
     #|4|#
     (18 56 57 9 0) (18 63 61 1/2 1) (18 68 64 5 2)
     (18 72 66 5 2) (18 75 68 5 3)
     (37/2 61 60 1/2 1) (19 60 59 1/2 1)
     (39/2 58 58 1/2 1) (20 60 59 1/2 1)
     (41/2 56 57 1/2 1) (21 66 63 3/2 1)
     (45/2 64 62 1/2 1) (23 63 61 1 1)
     (23 68 64 1 2) (23 72 66 1 2) (23 80 71 1 3)
     #|5|#    
     (24 64 62 3 1) (24 69 65 1 2) (24 73 67 1/2 3)
     (49/2 72 66 1/2 3) (25 73 67 1/2 3)
     (51/2 76 69 1/2 3) (26 81 72 3/2 3)
     (27 54 56 6 0) (27 63 61 6 1) (27 69 65 3 2)
     (55/2 80 71 1/2 3) (28 78 70 1/2 3)
     (57/2 76 69 1/2 3) (29 75 68 1/2 3)
     (59/2 73 67 1/2 3)
     #|6|#
     (30 68 64 1 2) (30 71 66 1/2 3)
     (61/2 69 65 1/2 3) (31 71 66 1/2 3)
     (63/2 75 68 1/2 3) (32 80 71 3/2 3)
     (33 52 55 6 0) (33 61 60 6 1) (33 68 64 3 2)
     (67/2 78 70 1/2 3) (34 76 69 1/2 3)
     (69/2 75 68 1/2 3) (35 73 67 1/2 3)
     (71/2 71 66 1/2 3)
     #|7|#
     (36 66 63 1 2) (36 69 65 1/2 3)
     (73/2 68 64 1/2 3) (37 69 65 1/2 3)
     (75/2 73 67 1/2 3) (38 78 70 3/2 3)
     (39 51 54 3 0) (39 59 59 7/2 1) (39 66 63 3 2)
     (79/2 76 69 1/2 3) (40 75 68 1/2 3)
     (81/2 73 67 1/2 3) (41 71 66 1/2 3)
     (83/2 69 65 1/2 3)
     #|8|#    
     (42 52 55 6 0) (42 64 62 3 2) (42 68 64 9/2 3)
     (85/2 57 58 1/2 1) (43 56 57 1/2 1)
     (87/2 54 56 1/2 1) (44 56 57 1/2 1)
     (89/2 52 55 1/2 1) (45 64 62 3/2 1)
     (93/2 63 61 1/2 1) (93/2 66 63 1/2 3)
     (47 61 60 1 1) (47 69 65 3/2 3)
     #|9|#
     (48 51 54 3 0) (48 60 59 15/2 1)
     (97/2 68 64 1/2 3) (49 66 63 1/2 3)
     (99/2 64 62 1/2 3) (50 66 63 1/2 3)
     (101/2 63 61 1/2 3) (51 56 57 3/2 0)
     (51 75 68 1/2 3) (103/2 73 67 1/2 3)
     (52 72 66 1/2 3) (105/2 54 56 1/2 0)
     (105/2 70 65 1/2 3) (53 56 57 1 0)
     (53 72 66 1/2 3) (107/2 68 64 1/2 3)
     #|10|#
     (54 49 53 9/2 0) (54 81 72 1/2 3)
     (109/2 80 71 1/2 3) (55 78 70 1/2 3)
     (111/2 61 60 1/2 1) (111/2 76 69 1/2 3)
     (56 63 61 1 1) (56 78 70 1/2 3)
     (113/2 75 68 1/2 3) (57 61 60 3 1)
     (57 76 69 9/2 3) (115/2 75 68 1/2 2)
     (58 73 67 1/2 2) (117/2 51 54 1/2 0)
     (117/2 71 66 1/2 2) (59 52 55 1 0)
     (59 73 67 1/2 2) (119/2 70 65 1/2 2)
     #|11|#
     (60 46 51 1/2 0) (60 67 63 3/2 2)
     (121/2 51 54 1/2 0) (61 49 53 1/2 0)
     (123/2 47 52 1/2 0) (123/2 68 64 1/2 2)
     (123/2 75 68 1/2 3) (62 49 53 1/2 0)
     (62 70 65 1 2) (62 73 67 1 3)
     (125/2 46 51 1/2 0) (63 43 49 1/2 0)
     (63 63 61 3/2 2) (63 73 67 3/2 3)
     (127/2 47 52 1/2 0) (64 46 51 1/2 0)
     (129/2 44 50 1/2 0) (129/2 65 62 1/2 2)
     (129/2 71 66 1/2 3) (65 46 51 1/2 0)
     (65 67 63 3/2 2) (65 70 65 1 3)
     (131/2 43 49 1/2 0)
     #|12|#
     (66 37 46 7/2 0) (66 70 65 1/2 3)
     (133/2 68 64 1/2 3) (67 67 63 1/2 3)
     (135/2 65 62 1/2 3) (68 67 63 1/2 3)
     (137/2 63 61 1/2 3) (69 67 63 2 2)
     (69 70 65 2 2) (69 75 68 7/2 3)
     (139/2 49 53 1/2 0) (70 47 52 1/2 0)
     (141/2 46 51 1/2 0) (71 47 52 1/2 0)
     (71 68 64 6 2) (143/2 44 50 1/2 0)
     #|13|#
     (72 52 55 3/2 0) (145/2 72 66 1/2 3)
     (73 73 67 1/2 3) (147/2 51 54 1/2 0)
     (147/2 75 68 1/2 3) (74 49 53 1 0)
     (74 76 69 1/2 3) (149/2 75 68 1/2 3)
     (75 51 54 2 0) (75 51 54 7/2 1)
     (75 71 66 3/2 3) (153/2 73 67 1/2 3)
     (77 39 47 1 0) (77 67 63 1 2) (77 70 65 1 3)
     #|14|#
     (78 44 50 6 0) (78 59 59 5 2) (78 63 61 5 2)
     (78 68 64 5 3) (157/2 49 53 1/2 1)
     (79 47 52 1/2 1) (159/2 46 51 1/2 1)
     (80 47 52 1/2 1) (161/2 44 50 1/2 1)
     (81 47 52 1/2 1) (163/2 51 54 1/2 1)
     (82 56 57 1/2 1) (165/2 52 55 1/2 1)
     (83 54 56 1/2 1) (83 71 66 3/2 3)
     (167/2 51 54 1/2 1)
     #|15|#
     (84 49 53 1/2 0) (84 52 55 3 1)
     (169/2 51 54 1/2 0) (169/2 68 64 1/2 3)
     (85 49 53 1/2 0) (85 70 65 1/2 3)
     (171/2 47 52 1/2 0) (171/2 73 67 1/2 3)
     (86 49 53 1/2 0) (86 76 69 3/2 3)
     (173/2 46 51 7/2 0) (87 54 56 3/2 1)
     (175/2 75 68 1/2 3) (88 76 69 1/2 3)
     (177/2 56 57 1/2 1) (177/2 80 71 1/2 3)
     (89 58 58 1 1) (89 78 70 1 3)
     #|16|#
     (90 59 59 7/2 0) (90 75 68 5 3)
     (181/2 73 67 1/2 2) (91 71 66 1/2 2)
     (183/2 70 65 1/2 2) (92 71 66 1/2 2)
     (92 71 66 3 3) (185/2 66 63 9/2 2)
     (93 63 61 3 2) (187/2 59 59 1/2 0)
     (94 57 58 1/2 0) (189/2 56 57 1/2 0)
     (95 57 58 1/2 0) (95 73 67 3/2 3)
     (191/2 54 56 1/2 0)
     #|17|#
     (96 51 54 1/2 0) (193/2 52 55 1/2 0)
     (193/2 70 65 1/2 3) (97 51 54 1/2 0)
     (97 72 66 1/2 3) (195/2 49 53 1/2 0)
     (195/2 75 68 1/2 3) (98 51 54 1/2 0)
     (98 51 54 4 1) (98 78 70 1/2 3)
     (197/2 48 52 1/2 0) (197/2 80 71 1/2 3)
     (99 44 50 3/2 0) (99 81 72 1/2 3)
     (199/2 80 71 1/2 3) (100 78 70 1/2 3)
     (201/2 46 51 1/2 0) (201/2 76 69 1/2 3)
     (101 48 52 1 0) (101 78 70 1/2 3)
     (203/2 75 68 1/2 3)
     #|18|#
     (102 49 53 7/2 0) (102 76 69 13/2 3)
     (205/2 75 68 1/2 2) (103 73 67 1/2 2)
     (207/2 72 66 1/2 2) (104 73 67 1/2 2)
     (104 73 67 4 3) (209/2 68 64 7/2 2)
     (105 64 62 3 2) (211/2 51 54 1/2 0)
     (106 52 55 1/2 0) (213/2 54 56 1/2 0)
     (107 56 57 1/2 0) (215/2 57 58 1/2 0)
     #|19|#
     (108 59 59 5/2 0) (217/2 74 68 1/2 3)
     (109 77 69 1/2 3) (219/2 61 60 1/2 1)
     (219/2 80 71 1/2 3) (110 62 61 2 1)
     (110 83 73 3/2 3) (221/2 59 59 1/2 0)
     (111 53 55 3 0) (223/2 74 68 1/2 3)
     (112 56 57 1 1) (112 73 67 1/2 3)
     (225/2 71 66 1/2 3) (113 61 60 3/2 1)
     (113 69 65 1/2 3) (227/2 68 64 1/2 3)
     #|20|#
     (114 54 56 6 0) (114 69 65 7/2 3)
     (229/2 59 59 1/2 1) (115 57 58 1/2 1)
     (231/2 56 57 1/2 1) (116 57 58 1/2 1)
     (233/2 54 56 1/2 1) (117 66 63 3/2 1)
     (235/2 68 64 1/2 3) (118 69 65 1/2 3)
     (237/2 64 62 1/2 1) (237/2 73 67 1/2 3)
     (119 63 61 1/2 1) (119 78 70 3/2 3)
     (239/2 61 60 1/2 1)
     #|21|#
     (120 56 57 3/2 0) (120 59 59 3/2 1)
     (241/2 76 69 1/2 3) (121 75 68 1/2 3)
     (243/2 57 58 1/2 0) (243/2 61 60 1/2 1)
     (243/2 73 67 1/2 3) (122 59 59 1 0)
     (122 63 61 5/2 1) (122 71 66 1/2 3)
     (245/2 69 65 1/2 3) (123 52 55 9/2 0)
     (123 68 64 1/2 3) (247/2 66 63 1/2 3)
     (124 68 64 1/2 3) (249/2 56 57 1/2 1)
     (249/2 71 66 1/2 3) (125 61 60 1/2 1)
     (125 76 69 3/2 3) (251/2 60 59 1/2 1)
     #|22|#
     (126 61 60 9/2 1) (253/2 75 68 1/2 3)
     (127 73 67 1/2 3) (255/2 51 54 1/2 0)
     (255/2 71 66 1/2 3) (128 49 53 1 0)
     (128 69 65 1/2 3) (257/2 68 64 1/2 3)
     (129 51 54 3 0) (129 66 63 1/2 3)
     (259/2 64 62 1/2 3) (130 66 63 1/2 3)
     (261/2 60 59 1/2 1) (261/2 69 65 1/2 3)
     (131 61 60 1/2 1) (131 75 68 3/2 3)
     (263/2 58 58 1/2 1)
     #|23|#
     (132 56 57 3/2 0) (132 60 59 3/2 1)
     (265/2 73 67 1/2 3) (133 72 66 1/2 3)
     (267/2 58 58 1/2 0) (267/2 61 60 1/2 1)
     (267/2 70 65 1/2 3) (134 60 59 1 0)
     (134 63 61 1 1) (134 68 64 1/2 3)
     (269/2 66 63 1/2 3) (135 61 60 3/2 0)
     (135 61 60 3 1) (135 64 62 1/2 3)
     (271/2 63 61 1/2 3) (136 64 62 1/2 3)
     (273/2 59 59 1/2 0) (273/2 68 64 1/2 3)
     (137 57 58 1/2 0) (137 73 67 3/2 3)
     (275/2 56 57 1/2 0)
     #|24|#
     (138 54 56 9/2 0) (138 57 58 3/2 1)
     (277/2 71 66 1/2 3) (139 69 65 1/2 3)
     (279/2 59 59 1/2 1) (279/2 68 64 1/2 3)
     (140 61 60 1 1) (140 69 65 1/2 3)
     (281/2 66 63 1/2 3) (141 62 61 3 1)
     (141 78 70 1/2 3) (283/2 76 69 1/2 3)
     (142 74 68 1/2 3) (285/2 52 55 1/2 0)
     (285/2 73 67 1/2 3) (143 54 56 1 0)
     (143 74 68 1/2 3) (287/2 69 65 1/2 3)
     #|25|#
     (144 51 54 3/2 0) (144 60 59 3 1)
     (144 81 72 1/2 3) (289/2 80 71 1/2 3)
     (145 78 70 1/2 3) (291/2 54 56 1/2 0)
     (291/2 76 69 1/2 3) (146 57 58 3/2 0)
     (146 78 70 1/2 3) (293/2 75 68 5 3)
     (147 66 63 1 1) (147 84 73 2 3)
     (295/2 56 57 1/2 0) (148 54 56 1/2 0)
     (297/2 52 55 1/2 0) (149 54 56 1/2 0)
     (149 80 71 1 3) (299/2 51 54 1/2 0)
     #|26|#
     (150 52 55 1/2 0) (150 80 71 7/2 3)
     (301/2 51 54 1/2 0) (151 49 53 1/2 0)
     (303/2 47 52 1/2 0) (303/2 76 69 1/2 2)
     (152 49 53 1/2 0) (152 72 66 1 2)
     (305/2 45 51 1/2 0) (153 57 58 7/2 0)
     (153 73 67 9/2 2) (307/2 78 70 1/2 3)
     (154 76 69 1/2 3) (309/2 75 68 1/2 3)
     (155 76 69 1/2 3) (311/2 73 67 1/2 3)
     #|27|#
     (156 78 70 7/2 3) (313/2 56 57 1/2 0)
     (157 54 56 1/2 0) (315/2 52 55 1/2 0)
     (315/2 72 66 1/2 2) (158 54 56 1/2 0)
     (158 75 68 1 2) (317/2 51 54 1/2 0)
     (159 60 59 3 0) (159 68 64 9/2 2)
     (319/2 76 69 1/2 3) (160 75 68 1/2 3)
     (321/2 73 67 1/2 3) (161 75 68 1/2 3)
     (323/2 68 64 1/2 3)
     #|28|#
     (162 61 60 1/2 0) (162 76 69 7/2 3)
     (325/2 59 59 1/2 0) (163 57 58 1/2 0)
     (327/2 56 57 1/2 0) (327/2 73 67 1/2 2)
     (164 57 58 1/2 0) (164 66 63 1/2 2)
     (329/2 54 56 1/2 0) (329/2 68 64 1/2 2)
     (165 66 63 7/2 0) (165 69 65 3 2)
     (331/2 75 68 1/2 3) (166 76 69 1/2 3)
     (333/2 78 70 1/2 3) (167 80 71 1/2 3)
     (335/2 81 72 1/2 3)
     #|29|#
     (168 68 64 3 2) (168 72 66 3/2 3)
     (337/2 64 62 1/2 0) (169 63 61 1/2 0)
     (339/2 61 60 1/2 0) (339/2 73 67 1/2 3)
     (170 60 59 1/2 0) (170 75 68 1 3)
     (341/2 58 58 1/2 0) (171 56 57 1/2 0)
     (171 60 59 3 2) (171 63 61 3 2)
     (171 66 63 7/2 3) (343/2 54 56 1/2 0)
     (172 52 55 1/2 0) (345/2 51 54 1/2 0)
     (173 49 53 1/2 0) (347/2 47 52 1/2 0)
     #|30|#
     (174 45 51 3/2 0) (349/2 64 62 1/2 3)
     (175 63 61 1/2 3) (351/2 47 52 1/2 0)
     (351/2 61 60 1/2 3) (176 44 50 1 0)
     (176 63 61 1/2 3) (353/2 60 59 1/2 3)
     (177 42 49 3/2 0) (177 69 65 1/2 3)
     (355/2 68 64 1/2 3) (178 66 63 1/2 3)
     (357/2 44 50 1/2 0) (357/2 64 62 1/2 3)
     (179 40 48 1 0) (179 66 63 1/2 3)
     (359/2 63 61 1/2 3)
     #|31|#
     (180 39 47 3/2 0) (180 72 66 1/2 3)
     (361/2 69 65 1/2 3) (181 68 64 1/2 3)
     (363/2 40 48 1/2 0) (363/2 66 63 1/2 3)
     (182 42 49 1 0) (182 68 64 1/2 3)
     (365/2 63 61 1/2 3) (183 36 45 3/2 0)
     (183 75 68 1/2 3) (367/2 73 67 1/2 3)
     (184 72 66 1/2 3) (369/2 39 47 1/2 0)
     (369/2 70 65 1/2 3) (185 42 49 1 0)
     (185 72 66 1/2 3) (371/2 68 64 1/2 3)
     #|32|#
     (186 40 48 1/2 0) (186 80 71 1 3)
     (373/2 52 55 1/2 0) (187 54 56 1/2 0)
     (187 78 70 1/2 3) (375/2 56 57 1/2 0)
     (375/2 76 69 1/2 3) (188 57 58 1/2 0)
     (188 75 68 1/2 3) (377/2 54 56 1/2 0)
     (377/2 73 67 1/2 3) (189 51 54 1/2 0)
     (189 72 66 1/2 3) (379/2 52 55 1/2 0)
     (379/2 73 67 1/2 3) (190 54 56 1/2 0)
     (190 75 68 1/2 3) (381/2 51 54 1/2 0)
     (381/2 78 70 1/2 3) (191 48 52 1/2 0)
     (191 69 65 3/2 3) (383/2 49 53 1/2 0)
     #|33|#
     (192 51 54 1/2 0) (385/2 48 52 1/2 0)
     (385/2 68 64 1/2 3) (193 44 50 1/2 0)
     (193 69 65 1/2 3) (387/2 46 51 1/2 0)
     (387/2 66 63 1/2 3) (194 48 52 1/2 0)
     (194 81 72 2 3) (389/2 49 53 1/2 0)
     (195 51 54 1/2 0) (391/2 52 55 1/2 0)
     (196 54 56 1/2 0) (196 80 71 1/2 3)
     (393/2 56 57 1/2 0) (393/2 78 70 1/2 3)
     (197 58 58 1/2 0) (197 76 69 1/2 3)
     (395/2 60 59 1/2 0) (395/2 75 68 1/2 3)
     #|34|#
     (198 61 60 1/2 0) (198 76 69 5/2 3)
     (397/2 59 59 1/2 0) (397/2 75 68 1/2 2)
     (199 57 58 1/2 0) (199 73 67 1/2 2)
     (399/2 56 57 1/2 0) (399/2 72 66 1/2 2)
     (200 57 58 1/2 0) (200 73 67 1 2)
     (401/2 54 56 1/2 0) (401/2 81 72 1/2 3)
     (201 56 57 2 0) (201 56 57 7/2 1)
     (201 73 67 2 2) (201 76 69 3/2 3)
     (405/2 78 70 1/2 3) (203 44 50 1 0)
     (203 72 66 1 2) (203 75 68 1 3)
     #|35|#
     (204 46 51 9/2 0) (204 73 67 9/2 3)
     (409/2 56 57 1/2 1) (409/2 71 66 1/2 2)
     (205 55 56 1/2 1) (205 70 65 1/2 2)
     (411/2 56 57 1/2 1) (411/2 68 64 1/2 2)
     (206 58 58 1/2 1) (206 67 63 1/2 2)
     (413/2 51 54 1/2 1) (413/2 68 64 1/2 2)
     (207 52 55 7/2 1) (207 67 63 7/2 2)
     (417/2 47 52 1/2 0) (417/2 76 69 1/2 3)
     (209 49 53 1 0) (209 75 68 1 3)
     #|36|#
     (210 43 49 9/2 0) (210 76 69 9/2 3)
     (421/2 51 54 1/2 1) (421/2 68 64 1/2 2)
     (211 49 53 1/2 1) (211 70 65 1/2 2)
     (423/2 47 52 1/2 1) (423/2 68 64 1/2 2)
     (212 49 53 1/2 1) (212 71 66 1/2 2)
     (425/2 52 55 1/2 1) (425/2 70 65 1/2 2)
     (213 55 56 3 1) (213 70 65 7/2 2)
     (429/2 44 50 1/2 0) (429/2 72 66 1/2 3)
     (215 46 51 1 0) (215 73 67 3/2 3)
     #|37|#
     (216 39 47 2 0) (216 79 70 5 3)
     (433/2 75 68 1/2 2) (217 76 69 1/2 2)
     (435/2 75 68 1/2 2) (218 73 67 1/2 2)
     (437/2 71 66 1/2 2) (219 70 65 1/2 2)
     (439/2 68 64 1/2 2)
     (220 67 63 1/2 2) (441/2 65 62 1/2 2)
     (221 66 63 1/2 2) (221 72 66 1 3)
     (221 80 71 1 3) (443/2 63 61 1/2 2)
     #|38|#
     (222 64 62 1/2 2) (222 73 67 9/2 3)
     (445/2 63 61 1/2 0) (445/2 71 66 1/2 2)
     (223 61 60 1/2 0) (223 69 65 1/2 2)
     (447/2 59 59 1/2 0) (447/2 68 64 1/2 2)
     (224 57 58 1/2 0) (224 66 63 1/2 2)
     (449/2 54 56 1/2 0) (449/2 69 65 1/2 2)
     (225 56 57 1/2 0) (225 64 62 3/2 2)
     (451/2 51 54 1/2 0) (226 52 55 1/2 0)
     (453/2 49 53 1/2 0) (453/2 66 63 1/2 2)
     (453/2 75 68 1/2 3) (227 44 50 1/2 1)
     (227 44 50 1 0) (227 63 61 1/2 2)
     (227 63 61 1 2) (227 72 66 1 3)
     (455/2 56 57 3/2 1) (455/2 66 63 1 2)
     #|39|#
     (228 49 53 6 0) (228 61 60 2 2)
     (228 73 67 5/2 3) (457/2 68 64 1/2 2)
     (229 54 56 1 1) (229 69 65 1/2 2)
     (459/2 66 63 3/2 2) (230 57 58 1 1)
     (230 63 61 1 2) (461/2 72 66 1/2 3)
     (231 56 57 3 1) (231 65 62 3 2) (231 68 64 3 2)
     (231 73 67 3 3)))   
#|
  (saveit
   (concatenate
    'string
    "/Users/tec69/Open/Potential thesis chapters"
    "/Exhaustive algorithms for discovering exact"
    " translational patterns in Scarlatti's"
    " keyboard sonatas/MIDI/BWV 849.mid")
   (modify-to-check-dataset dataset 1500))
|#
)

