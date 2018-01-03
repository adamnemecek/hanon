#| Tom Collins
   Tuesday 3 February 2010
   Completed Tuesday 3 February 2010 |#

#| The purpose is to create a vector representation
of Scarlatti's Sonata in C Minor, L. 10 (K. 84).

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
  "keyboard sonatas/Director musices/L 10.txt"))
|#

(progn
  (setq
   dataset
   '(#|1|#
     (0 48 53 1 1) (1/2 60 60 1/2 0) (1 63 62 1/2 0)
     (3/2 67 64 1/2 0) (2 72 67 1/2 0)
     (5/2 75 69 1/2 0)
     #|2|#
     (3 79 71 1/2 0) (7/2 84 74 1/2 0)
     (4 79 71 1/2 0) (9/2 75 69 1/2 0)
     (5 72 67 1/2 0) (11/2 67 64 1/2 0)
     #|3|# 
     (6 60 60 1 0) (13/2 48 53 1/2 1)
     (7 51 55 1/2 1) (15/2 55 57 1/2 1)
     (8 60 60 1/2 1) (17/2 63 62 1/2 1)
     #|4|#
     (9 67 64 1/2 1) (19/2 72 67 1/2 1)
     (10 67 64 1/2 1) (21/2 63 62 1/2 1)
     (11 60 60 1/2 1) (23/2 55 57 1/2 1)
     #|5|#
     (12 48 53 1 1) (49/4 79 71 1/4 0)
     (25/2 81 72 1/4 0) (51/4 83 73 1/4 0)
     (13 67 64 1 1) (13 75 69 1/2 0)
     (13 84 74 1/2 0) (27/2 74 68 1/2 0)
     (27/2 83 73 1/2 0) (14 67 64 1 1)
     (14 75 69 1/2 0) (14 84 74 1/2 0)
     (29/2 74 68 1/2 0) (29/2 83 73 1/2 0)
     #|6|#    
     (15 75 69 1 0) (15 84 74 1 0) (61/4 67 64 1/4 1)
     (31/2 69 65 1/4 1) (63/4 71 66 1/4 1)
     (16 63 62 1/2 1) (16 72 67 1/2 1) (16 79 71 1 0)
     (33/2 62 61 1/2 1) (33/2 71 66 1/2 1)
     (17 63 62 1/2 1) (17 72 67 1/2 1) (17 79 71 1 0)
     (35/2 62 61 1/2 1) (35/2 71 66 1/2 1)
     #|7|#
     (18 63 62 1 1) (18 72 67 1 1) (73/4 79 71 1/4 0)
     (37/2 81 72 1/4 0) (75/4 83 73 1/4 0)
     (19 67 64 1 1) (19 75 69 1/2 0) (19 84 74 1/2 0)
     (39/2 74 68 1/2 0) (39/2 83 73 1/2 0)
     (20 67 64 1 1) (20 75 69 1/2 0) (20 84 74 1/2 0)
     (41/2 74 68 1/2 0) (41/2 83 73 1/2 0)
     #|8|#
     (21 75 69 1 0) (21 84 74 1 0) (85/4 67 64 1/4 1)
     (43/2 69 65 1/4 1) (87/4 71 66 1/4 1)
     (22 63 62 1/2 1) (22 72 67 1/2 1) (22 79 71 1 0)
     (45/2 62 61 1/2 1) (45/2 71 66 1/2 1)
     (23 63 62 1/2 1) (23 72 67 1/2 1) (23 79 71 1 0)
     (47/2 62 61 1/2 1) (47/2 71 66 1/2 1)
     #|9|#
     (24 63 62 1 1) (24 72 67 1 1) (49/2 79 71 1/2 0)
     (25 84 74 1/2 0) (51/2 75 69 1/2 1)
     (103/4 79 71 1/4 0) (26 77 70 1/2 1)
     (105/4 80 72 1/4 0) (53/2 74 68 1/2 1)
     (107/4 77 70 1/4 0)
     #|10|#
     (27 75 69 1/2 1) (109/4 79 71 1/4 0)
     (55/2 71 66 1/2 1) (111/4 74 68 1/4 0)
     (28 72 67 1/2 1) (113/4 75 69 1/4 0)
     (57/2 67 64 1/2 1) (115/4 71 66 1/4 0)
     (29 68 65 1/2 1) (117/4 72 67 1/4 0)
     (59/2 63 62 1/2 1) (119/4 67 64 1/4 0)
     #|11|#
     (30 65 63 1/2 1) (121/4 68 65 1/4 0)
     (61/2 62 61 1/2 1) (123/4 65 63 1/4 0)
     (31 63 62 1/2 1) (125/4 67 64 1/4 0)
     (63/2 59 59 1/2 1) (127/4 62 61 1/4 0)
     (32 60 60 1/2 1) (129/4 63 62 1/4 0)
     (65/2 53 56 1/2 1) (131/4 65 63 1/4 0)
     #|12|#
     (33 43 50 1/2 1) (133/4 62 61 1/4 0)
     (67/2 64 62 1/4 0) (135/4 66 63 1/4 0)
     (34 59 59 1/2 0) (34 67 64 1/2 0)
     (69/2 57 58 1/2 0) (69/2 66 63 1/2 0)
     (35 59 59 1/2 0) (35 67 64 1/2 0)
     (71/2 57 58 1/2 0) (71/2 66 63 1/2 0)
     #|13|#
     (36 59 59 1/2 0) (36 67 64 1/2 0)
     (145/4 50 54 1/4 1) (73/2 52 55 1/4 1)
     (147/4 54 56 1/4 1) (37 47 52 1/2 1)
     (37 55 57 1/2 1) (37 62 61 1 0)
     (75/2 45 51 1/2 1) (75/2 54 56 1/2 1)
     (38 47 52 1/2 1) (38 55 57 1/2 1) (38 62 61 1 0)
     (77/2 45 51 1/2 1) (77/2 54 56 1/2 1)
     #|14|#
     (39 47 52 1/2 1) (39 55 57 1/2 1)
     (79/2 79 71 1/2 0) (40 60 60 1 1)
     (40 68 65 1/2 0) (40 77 70 1/2 0)
     (81/2 67 64 1/2 0) (81/2 76 69 1/2 0)
     (41 60 60 1 1) (41 68 65 1/2 0) (41 77 70 1/2 0)
     (83/2 67 64 1/2 0) (83/2 76 69 1/2 0)
     #|15|#
     (42 68 65 1/2 0) (42 77 70 1/2 0)
     (169/4 60 60 1/4 1) (85/2 62 61 1/4 1)
     (171/4 64 62 1/4 1) (43 56 58 1/2 1)
     (43 65 63 1/2 1) (43 72 67 1 0)
     (87/2 55 57 1/2 1) (87/2 64 62 1/2 1)
     (44 56 58 1/2 1) (44 65 63 1/2 1) (44 72 67 1 0)
     (89/2 55 57 1/2 1) (89/2 64 62 1/2 1)
     #|16|#
     (45 56 58 1/2 1) (45 65 63 1/2 1)
     (91/2 68 65 1/2 0) (91/2 77 70 1/2 0)
     (46 58 59 1 1) (46 67 64 1/2 0) (46 75 69 1/2 0)
     (93/2 65 63 1/2 0) (93/2 74 68 1/2 0)
     (47 58 59 1 1) (47 67 64 1/2 0) (47 75 69 1/2 0)
     (95/2 65 63 1/2 0) (95/2 74 68 1/2 0)
     #|17|#
     (48 67 64 1/2 0) (48 75 69 1/2 0)
     (193/4 58 59 1/4 1) (97/2 60 60 1/4 1)
     (195/4 62 61 1/4 1) (49 55 57 1/2 1)
     (49 63 62 1/2 1) (49 70 66 1 0)
     (99/2 53 56 1/2 1) (99/2 62 61 1/2 1)
     (50 55 57 1/2 1) (50 63 62 1/2 1) (50 70 66 1 0)
     (101/2 53 56 1/2 1) (101/2 62 61 1/2 1)
     #|18|#
     (51 55 57 1/2 1) (51 63 62 1/2 1)
     (103/2 67 64 1/2 0) (103/2 75 69 1/2 0)
     (52 41 49 1 1) (52 53 56 1 1) (52 67 64 1/2 0)
     (52 75 69 1/2 0) (105/2 65 63 1/2 0)
     (105/2 74 68 1/2 0) (53 42 49 1 1)
     (53 54 56 1 1) (53 65 63 1/2 0)
     (53 74 68 1/2 0) (107/2 63 62 1/2 0)
     (107/2 72 67 1/2 0)
     #|19|#
     (54 43 50 1 1) (54 55 57 1 1) (54 63 62 1/2 0)
     (54 72 67 1/2 0) (109/2 62 61 1/2 0)
     (109/2 71 66 1/2 0) (55 62 61 1/2 0)
     (55 71 66 1/2 0) (111/2 63 62 1/2 0)
     (111/2 72 67 1/2 0) (56 63 62 1/2 0)
     (56 72 67 1/2 0) (113/2 65 63 1/2 0)
     (113/2 74 68 1/2 0)
     #|20|#
     (57 43 50 1 1) (57 55 57 1 1) (57 65 63 1/2 0)
     (57 74 68 1/2 0) (115/2 67 64 1/2 0)
     (115/2 75 69 1/2 0) (58 67 64 1/2 0)
     (58 75 69 1/2 0) (117/2 68 65 1/2 0)
     (117/2 77 70 1/2 0) (59 68 65 1/2 0)
     (59 77 70 1/2 0) (119/2 71 66 1/2 0)
     (119/2 74 68 1/2 0)
     #|21|#
     (60 43 50 1 1) (60 55 57 1 1) (60 71 66 1/2 0)
     (60 74 68 1/2 0) (121/2 72 67 1/2 0)
     (121/2 75 69 1/2 0) (61 72 67 1/2 0)
     (61 75 69 1/2 0) (123/2 74 68 1/2 0)
     (123/2 77 70 1/2 0) (62 74 68 1/2 0)
     (62 77 70 1/2 0) (125/2 75 69 1/2 0)
     (125/2 79 71 1/2 0)
     #|22|#
     (63 43 50 1 1) (63 55 57 1 1) (63 75 69 1/2 0)
     (63 79 71 1/2 0) (127/2 74 68 1/2 0)
     (127/2 77 70 1/2 0) (64 74 68 1/2 0)
     (64 77 70 1/2 0) (129/2 72 67 1/2 0)
     (129/2 75 69 1/2 0) (65 72 67 1/2 0)
     (65 75 69 1/2 0) (131/2 71 66 1/4 0)
     (131/2 74 68 1/4 0) (263/4 69 65 1/4 0)
     (263/4 72 67 1/4 0)
     #|23|#
     (66 43 50 1 1) (66 55 57 1 1) (66 71 66 1/2 0)
     (66 74 68 1/2 0) (133/2 79 71 1/2 0)
     (67 80 72 1/2 0) (67 84 74 1 0)
     (135/2 78 70 1/2 0) (68 79 71 1/2 0)
     (68 83 73 1 0) (137/2 74 68 1/2 0)
     #|24|#  
     (69 43 50 1 1) (69 55 57 1 1) (69 75 69 1/2 0)
     (69 84 74 1 0) (139/2 72 67 1/2 0)
     (70 77 70 1/2 0) (70 80 72 1 0)
     (141/2 74 68 1/2 0) (71 75 69 1/2 0)
     (71 79 71 1 0) (143/2 72 67 1/2 0)
     #|25|#
     (72 43 50 1 1) (72 55 57 1 1) (72 73 68 1/2 0)
     (72 77 70 1 0) (145/2 71 66 1/2 0)
     (73 72 67 1/2 0) (73 75 69 1 0)
     (147/2 67 64 1/2 0) (74 68 65 1/2 0)
     (74 72 67 1 0) (149/2 66 63 1/2 0)
     #|26|#
     (75 43 50 1 1) (75 55 57 1 1) (75 67 64 1/2 0)
     (75 71 66 1 0) (151/2 62 61 1/2 0)
     (76 63 62 1/2 0) (76 72 67 1 0)
     (153/2 60 60 1/2 0) (77 65 63 1/2 0)
     (77 68 65 1 0) (155/2 62 61 1/2 0)
     #|27|#
     (78 43 50 1 1) (78 55 57 1 1) (78 63 62 1/2 0)
     (78 67 64 1 0) (157/2 60 60 1/2 0)
     (79 61 61 1/2 0)  (79 65 63 1 0)
     (159/2 59 59 1/2 0) (80 60 60 1/2 0)
     (80 63 62 1/2 0) (161/2 59 59 1/4 0)
     (161/2 62 61 1/4 0) (323/4 57 58 1/4 0)
     (323/4 60 60 1/4 0)
     #|28|#
     (81 55 57 1/2 0) (81 59 59 1/2 0)
     (325/4 43 50 1/4 1) (163/2 45 51 1/4 1)
     (327/4 47 52 1/4 1) (82 48 53 1/4 1)
     (329/4 50 54 1/4 1) (165/2 52 55 1/4 1)
     (331/4 54 56 1/4 1) (83 55 57 1/4 1)
     (333/4 57 58 1/4 0) (167/2 59 59 1/4 0)
     (335/4 60 60 1/4 0)
     #|29|#
     (84 62 61 1/2 0) (169/2 64 62 1/4 0)
     (339/4 66 63 1/4 0) (85 67 64 1/4 0)
     (341/4 69 65 1/4 0) (171/2 71 66 1/4 0)
     (343/4 72 67 1/4 0) (86 74 68 1/2 0)
     (173/2 76 69 1/4 0) (347/4 78 70 1/4 0)
     #|30|#
     (87 79 71 1/2 1) (349/4 79 71 1/4 0)
     (175/2 74 68 1/2 1) (351/4 74 68 1/4 0)
     (88 71 66 1/2 1) (353/4 71 66 1/4 0)
     (177/2 67 64 1/2 0) (355/4 67 64 1/4 0)
     (89 62 61 1/4 0) (357/4 62 61 1/4 0)
     (179/2 59 59 1/2 0) (359/4 59 59 1/4 0)
     #|31|#
     (90 43 50 1 1) (181/2 55 57 1/2 0)
     (91 59 59 1/2 0) (183/2 62 61 1/2 0)
     (92 67 64 1/2 0) (185/2 71 66 1/2 0)
     #|32|#
     (93 74 68 1 0) (187/2 43 50 1/2 1)
     (94 47 52 1/2 1) (189/2 50 54 1/2 1)
     (95 55 57 1/2 1) (191/2 59 59 1/2 1)
     #|33|#
     (96 62 61 1 1) (193/2 66 63 1/2 0)
     (193/2 74 68 1/2 0) (97 66 63 1/2 0)
     (97 74 68 1/2 0) (195/2 63 62 1/2 0)
     (195/2 72 67 1/2 0) (98 63 62 1/2 0)
     (98 72 67 1/2 0) (197/2 62 61 1/2 0)
     (197/2 70 66 1/2 0)
     #|34|#
     (99 62 61 1/2 0) (99 70 66 1/2 0)
     (199/2 60 60 1/2 0) (199/2 69 65 1/2 0)
     (100 60 60 1/2 0) (100 69 65 1/2 0)
     (201/2 58 59 1/2 0) (201/2 67 64 1/2 0)
     (101 58 59 1/2 0) (101 67 64 1/2 0)
     (203/2 57 58 1/2 0) (203/2 66 63 1/2 0)
     #|35|#
     (102 57 58 1/2 0) (102 66 63 1/2 0)
     (205/2 58 59 1/2 1) (205/2 67 64 1/2 1)
     (103 58 59 1/2 1) (103 67 64 1/2 1)
     (207/2 57 58 1/2 1) (207/2 65 63 1/2 1)
     (104 57 58 1/2 1) (104 65 63 1/2 1)
     (209/2 55 57 1/2 1) (209/2 63 62 1/2 1)
     #|36|#
     (105 55 57 1/2 1) (105 63 62 1/2 1)
     (211/2 54 56 1/2 1) (211/2 62 61 1/2 1)
     (106 54 56 1/2 1) (106 62 61 1/2 1)
     (213/2 52 55 1/2 1) (213/2 61 60 1/2 1)
     (107 52 55 1/2 1) (107 61 60 1/2 1)
     (215/2 50 54 1/2 1) (215/2 62 61 1/2 1)
     #|37|#
     (108 50 54 1/2 1) (108 62 61 1/2 1)
     (217/2 74 68 1/2 0) (109 75 69 1/2 0)
     (219/2 69 65 1/2 1)  (439/4 72 67 1/4 0)
     (110 70 66 1/2 1) (441/4 74 68 1/4 0)
     (221/2 66 63 1/2 1) (443/4 69 65 1/4 0)
     #|38|#  
     (111 67 64 1/2 1) (445/4 70 66 1/4 0)
     (223/2 62 61 1/2 1) (447/4 66 63 1/4 0)
     (112 63 62 1/2 1) (449/4 67 64 1/4 0)
     (225/2 58 59 1/2 1) (451/4 62 61 1/4 0)
     (113 60 60 1/2 1) (453/4 63 62 1/4 0)
     (227/2 57 58 1/2 1)
     (455/4 60 60 1/4 0)
     #|39|#
     (114 58 59 1/2 1) (229/2 79 71 1/2 0)
     (115 80 72 1/2 0) (231/2 74 68 1/2 1)
     (463/4 77 70 1/4 0) (116 75 69 1/2 1)
     (465/4 79 71 1/4 0) (233/2 71 66 1/2 1)
     (467/4 74 68 1/4 0)
     #|40|#
     (117 72 67 1/2 1) (469/4 75 69 1/4 0)
     (235/2 67 64 1/2 1) (471/4 71 66 1/4 0)
     (118 68 65 1/2 1) (473/4 72 67 1/4 0)
     (237/2 63 62 1/2 1) (475/4 67 64 1/4 0)
     (119 65 63 1/2 1) (477/4 68 65 1/4 0)
     (239/2 62 61 1/2 1) (479/4 65 63 1/4 0)
     #|41|#
     (120 63 62 1 1) (241/2 67 64 1/2 0)
     (241/2 79 71 1/2 0) (121 62 61 1 1)
     (121 69 65 1 0) (121 79 71 1/2 0)
     (243/2 77 70 1/2 0) (122 55 57 1 1)
     (122 71 66 1 0) (122 77 70 1/2 0)
     (245/2 75 69 1/4 0) (491/4 74 68 1/4 0)
     #|42|#
     (123 48 53 1 1) (123 72 67 1 0)
     (123 75 69 1/2 0) (247/2 84 74 1/2 0)
     (124 48 53 1 1) (124 74 68 1 0)
     (124 84 74 1/2 0) (249/2 82 73 1/2 0)
     (125 48 53 1 1) (125 76 69 1 0)
     (125 82 73 1/2 0) (251/2 80 72 1/4 0)
     (503/4 79 71 1/4 0)
     #|43|#
     (126 53 56 1 1) (126 77 70 1 0) (126 80 72 1 0)
     (253/2 65 63 1/2 1) (127 53 56 1 1)
     (127 65 63 1/2 1) (127 77 70 1 0)
     (127 80 72 1 0) (255/2 63 62 1/2 1)
     (128 55 57 1/2 1) (128 63 62 1 1)
     (128 75 69 1 0) (128 79 71 1 0)
     (257/2 56 58 1/2 1)
     #|44|#
     (129 58 59 1 1) (129 62 61 1 1)
     (129 74 68 1/2 0) (129 77 70 1/2 0)
     (259/2 70 66 1/2 0) (259/2 82 73 1/2 0)
     (130 46 52 1 1) (130 72 67 1 0)
     (130 82 73 1/2 0) (261/2 80 72 1/2 0)
     (131 46 52 1 1) (131 74 68 1 0)
     (131 80 72 1/2 0) (263/2 79 71 1/4 0)
     (527/4 77 70 1/4 0)
     #|45|#
     (132 51 55 1 1) (132 75 69 1 0) (132 79 71 1 0)
     (265/2 63 62 1/2 1) (133 51 55 1 1)
     (133 63 62 1/2 1) (133 75 69 1 0)
     (133 79 71 1 0) (267/2 62 61 1/2 1)
     (134 53 56 1/2 1) (134 62 61 1 1)
     (134 74 68 1 0) (134 77 70 1 0)
     (269/2 55 57 1/2 1)
     #|46|#
     (135 56 58 1 1) (135 60 60 1 1)
     (135 72 67 1/2 0) (135 75 69 1/2 0)
     (271/2 68 65 1/2 0) (271/2 80 72 1/2 0)
     (136 44 51 1 1) (136 70 66 1 0)
     (136 80 72 1/2 0) (273/2 79 71 1/2 0)
     (137 44 51 1 1) (137 72 67 1 0)
     (137 79 71 1/2 0) (275/2 77 70 1/4 0)
     (551/4 75 69 1/4 0)
     #|47|#
     (138 50 54 1 1) (138 74 68 1 0) (138 77 70 1 0)
     (277/2 62 61 1/2 1) (139 50 54 1 1)
     (139 62 61 1/2 1) (139 74 68 1 0)
     (139 77 70 1 0) (279/2 60 60 1/2 1)
     (140 51 55 1/2 1) (140 60 60 1 1)
     (140 72 67 1 0) (140 75 69 1 0)
     (281/2 53 56 1/2 1)
     #|48|#
     (141 55 57 1 1) (141 59 59 1 1)
     (141 71 66 1/2 0) (141 74 68 1/2 0)
     (283/2 67 64 1/2 0) (283/2 79 71 1/2 0)
     (142 43 50 1 1) (142 69 65 1 0)
     (142 79 71 1/2 0) (285/2 77 70 1/2 0)
     (143 43 50 1 1) (143 71 66 1 0)
     (143 77 70 1/2 0) (287/2 75 69 1/4 0)
     (575/4 74 68 1/4 0)
     #|49|#
     (144 48 53 1 1) (144 72 67 1/2 0)
     (144 75 69 1 0) (289/2 67 64 1/2 0)
     (145 53 56 1 1) (145 68 65 1/2 0)
     (145 74 68 1 0) (291/2 65 63 1/2 0)
     (146 56 58 1 1) (146 63 62 1/2 0)
     (146 72 67 1 0) (293/2 60 60 1/2 0)
     #|50|#
     (147 55 57 1/2 1) (147 62 61 1/2 0)
     (147 71 66 1/2 0) (295/2 80 72 1/2 0)
     (295/2 84 74 1/2 0) (148 80 72 1/2 0)
     (148 84 74 1/2 0) (297/2 79 71 1/2 0)
     (297/2 83 73 1/2 0) (149 79 71 1/2 0)
     (149 83 73 1/2 0) (299/2 80 72 1/2 0)
     (299/2 84 74 1/2 0)
     #|51|#
     (150 43 50 1 1) (150 80 72 1/2 0)
     (150 84 74 1/2 0) (301/2 79 71 1/2 0)
     (301/2 82 73 1/2 0) (151 55 57 1 1)
     (151 79 71 1/2 0) (151 82 73 1/2 0)
     (303/2 78 70 1/2 0) (303/2 81 72 1/2 0)
     (152 54 56 1 1) (152 78 70 1/2 0)
     (152 81 72 1/2 0) (305/2 79 71 1/2 0)
     (305/2 82 73 1/2 0)
     #|52|#
     (153 43 50 1 1) (153 55 57 1 1)
     (153 79 71 1/2 0) (153 82 73 1/2 0)
     (307/2 77 70 1/2 0) (307/2 80 72 1/2 0)
     (154 53 56 1 1) (154 77 70 1/2 0)
     (154 80 72 1/2 0) (309/2 76 69 1/2 0)
     (309/2 79 71 1/2 0) (155 52 55 1 1)
     (155 76 69 1/2 0) (155 79 71 1/2 0)
     (311/2 77 70 1/2 0) (311/2 80 72 1/2 0)
     #|53|#
     (156 43 50 1 1) (156 53 56 1 1)
     (156 77 70 1/2 0) (156 80 72 1/2 0)
     (313/2 75 69 1/2 0) (313/2 79 71 1/2 0)
     (157 51 55 1 1) (157 75 69 1/2 0)
     (157 79 71 1/2 0) (315/2 74 68 1/2 0)
     (315/2 78 70 1/2 0) (158 50 54 1 1)
     (158 74 68 1/2 0) (158 78 70 1/2 0)
     (317/2 75 69 1/2 0) (317/2 79 71 1/2 0)
     #|54|#
     (159 43 50 1 1) (159 51 55 1 1)
     (159 75 69 1/2 0) (159 79 71 1/2 0)
     (319/2 73 68 1/2 0) (319/2 77 70 1/2 0)
     (160 49 54 1 1) (160 73 68 1/2 0)
     (160 77 70 1/2 0) (321/2 72 67 1/2 0)
     (321/2 76 69 1/2 0) (161 48 53 1 1)
     (161 72 67 1/2 0) (161 76 69 1/2 0)
     (323/2 73 68 1/2 0) (323/2 77 70 1/2 0)
     #|55|#
     (162 43 50 1 1) (162 49 54 1 1)
     (162 73 68 1/2 0) (162 77 70 1/2 0)
     (325/2 72 67 1/2 0) (325/2 75 69 1/2 0)
     (163 48 53 1 1) (163 72 67 1/2 0)
     (163 75 69 1/2 0) (327/2 71 66 1/2 0)
     (327/2 74 68 1/2 0) (164 47 52 1 1)
     (164 71 66 1/2 0) (164 74 68 1/2 0)
     (329/2 72 67 1/2 0) (329/2 75 69 1/2 0)
     #|56|#
     (165 43 50 1 1) (165 55 57 1 1)
     (165 72 67 1/2 0) (165 75 69 1 0)
     (331/2 67 64 1/2 0) (166 68 65 1/2 0)
     (166 72 67 1 0) (333/2 66 63 1/2 0)
     (167 67 64 1/2 0) (167 71 66 1 0)
     (335/2 62 61 1/2 0)
     #|57|#
     (168 43 50 1 1) (168 55 57 1 1)
     (168 63 62 1/2 0) (168 72 67 1 0)
     (337/2 60 60 1/2 0) (169 65 63 1/2 0)
     (169 68 65 1 0) (339/2 62 61 1/2 0)
     (170 63 62 1/2 0) (170 67 64 1 0)
     (341/2 60 60 1/2 0)
     #|58|#
     (171 43 50 1 1) (171 55 57 1 1)
     (171 61 61 1/2 0) (171 65 63 1 0)
     (343/2 59 59 1/2 0) (172 60 60 1/4 0)
     (172 63 62 1 0) (689/4 55 57 1/4 0)
     (345/2 57 58 1/4 0) (691/4 59 59 1/4 0)
     (173 60 60 1/4 0) (693/4 62 61 1/4 0)
     (347/2 63 62 1/4 0) (695/4 65 63 1/4 0)
     #|59|#
     (174 67 64 1 0) (349/2 55 57 1/2 1)
     (349/2 63 62 1/2 1) (175 55 57 1/2 1)
     (175 63 62 1/2 1) (175 67 64 1 0)
     (351/2 53 56 1/2 1) (351/2 62 61 1/2 1)
     (176 53 56 1/2 1) (176 62 61 1/2 1)
     (176 67 64 1 0) (353/2 51 55 1/2 1)
     (353/2 60 60 1/2 1)
     #|60|#
     (177 51 55 1/2 1) (177 60 60 1/2 1)
     (177 67 64 1 0) (355/2 50 54 1/2 1)
     (355/2 58 59 1/2 1) (178 50 54 1/2 1)
     (178 58 59 1/2 1) (178 67 64 1 0)
     (357/2 48 53 1/2 1) (357/2 56 58 1/2 1)
     (179 48 53 1/2 1) (179 56 58 1/2 1)
     (179 67 64 1 0) (359/2 47 52 1/2 1)
     (359/2 55 57 1/2 1)
     #|61|#
     (180 47 52 1 1) (180 55 57 1 1)
     (721/4 62 61 1/4 0) (361/2 63 62 1/4 0)
     (723/4 65 63 1/4 0) (181 67 64 1/4 0)
     (725/4 69 65 1/8 0) (1451/8 71 66 1/8 0)
     (363/2 47 52 1/2 1) (363/2 55 57 1/2 1)
     (363/2 72 67 1/4 0) (727/4 74 68 1/4 0)
     (182 48 53 1 1) (182 55 57 1 1)
     (182 75 69 1/2 0) (365/2 72 67 1/2 0)
     #|62|#
     (183 47 52 1 1) (183 55 57 1 1)
     (733/4 62 61 1/4 0) (367/2 63 62 1/4 0)
     (735/4 65 63 1/4 0) (184 67 64 1/4 0)
     (737/4 69 65 1/8 0) (1475/8 71 66 1/8 0)
     (369/2 47 52 1/2 1) (369/2 55 57 1/2 1)
     (369/2 72 67 1/4 0) (739/4 74 68 1/4 0)
     (185 48 53 1/2 1) (185 55 57 1 1)
     (185 75 69 1/2 0) (371/2 51 55 1/2 1)
     (371/2 72 67 1/2 0)
     #|63|#
     (186 53 56 1 1) (186 68 65 1 0)
     (373/2 77 70 1/2 0) (187 55 57 1 1)
     (187 67 64 1 0) (187 75 69 1/2 0)
     (375/2 72 67 1/2 0) (188 43 50 1 1)
     (188 65 63 1 0) (188 74 68 1/2 0)
     (377/2 71 66 1/2 0)
     #|64|#
     (189 47 52 1 1) (189 55 57 1 1)
     (757/4 62 61 1/4 0) (379/2 63 62 1/4 0)
     (759/4 65 63 1/4 0) (190 67 64 1/4 0)
     (761/4 69 65 1/8 0) (1523/8 71 66 1/8 0)
     (381/2 47 52 1/2 1) (381/2 55 57 1/2 1)
     (381/2 72 67 1/4 0) (763/4 74 68 1/4 0)
     (191 48 53 1 1) (191 55 57 1 1)
     (191 75 69 1/2 0) (383/2 72 67 1/2 0)
     #|65|#
     (192 47 52 1 1) (192 55 57 1 1)
     (769/4 62 61 1/4 0) (385/2 63 62 1/4 0)
     (771/4 65 63 1/4 0) (193 67 64 1/4 0)
     (773/4 69 65 1/8 0) (1547/8 71 66 1/8 0)
     (387/2 47 52 1/2 1) (387/2 55 57 1/2 1)
     (387/2 72 67 1/4 0) (775/4 74 68 1/4 0)
     (194 48 63 1/2 1) (194 55 57 1 1)
     (194 75 69 1/2 0) (389/2 51 55 1/2 1)
     (389/2 72 67 1/2 0)
     #|66|#
     (195 53 56 1/2 1) (195 68 65 1/2 0)
     (391/2 41 49 1/2 1) (391/2 74 68 1/2 0)
     (196 55 57 1 1) (196 63 62 1/2 0)
     (393/2 72 67 1/2 0) (197 43 50 1 1)
     (197 62 61 1/2 0) (395/2 71 66 1/2 0)
     #|67|#  
     (198 72 67 1 0) (793/4 48 53 1/4 1)
     (397/2 50 54 1/4 1) (795/4 51 55 1/4 1)
     (199 53 56 1/4 1) (797/4 55 57 1/4 1)
     (399/2 57 58 1/4 1) (799/4 59 59 1/4 1)
     (200 60 60 1/4 1) (801/4 62 61 1/4 0)
     (401/2 63 62 1/4 0) (803/4 65 63 1/4 0)
     #|68|#
     (201 67 64 1/2 0) (403/2 69 65 1/4 0)
     (807/4 71 66 1/4 0) (202 72 67 1/4 0)
     (809/4 74 68 1/4 0) (405/2 75 69 1/4 0)
     (811/4 77 70 1/4 0) (203 79 71 1/2 0) 
     (407/2 81 72 1/4 0) (815/4 83 73 1/4 0)
     #|69|#
     (204 84 74 1/2 1) (817/4 84 74 1/4 0)
     (409/2 79 71 1/2 1) (819/4 79 71 1/4 0)
     (205 75 69 1/2 1) (821/4 75 69 1/4 0)
     (411/2 72 67 1/2 1) (823/4 72 67 1/4 0)
     (206 67 64 1/2 1) (825/4 67 64 1/4 0)
     (413/2 63 62 1/2 1) (827/4 63 62 1/4 0)
     (207 36 46 1 1)))
#|
  (saveit
   (concatenate
    'string
    "/Users/tec69/Open/Potential thesis chapters"
    "/Exhaustive algorithms for discovering exact"
    " translational patterns in Scarlatti's"
    " keyboard sonatas/MIDI/L 10.mid")
   (modify-to-check-dataset dataset 1000))
|#
)
