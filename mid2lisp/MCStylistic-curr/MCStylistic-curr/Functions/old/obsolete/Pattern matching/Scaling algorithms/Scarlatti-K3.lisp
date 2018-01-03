#| At the bottom of this file is the dataset for
Scarlatti's Keyboard Sonata in A Minor, K. 3,
with each datapoint consisting of an ontime, MIDI
note number, note height and duration in that order.
Bar numbers are commented in to aid navigation.

(progn
  (setq E
        ;;(orthogonal-projection-not-unique-equalp
         (firstn 5 dataset))
         ;;'(1 0 1 0)))
  (print "Small dataset defined"))

These were the preliminaries:
(in-package :common-lisp-user)
(load "//Applications/CCL/Lisp code/sort-by.lisp")
(load "//Applications/CCL/Lisp code/choose.lisp")
(load "//Applications/CCL/Lisp code/chords.lisp")
(load "//Applications/CCL/Lisp code/markov-analyse.lisp")
(load "//Applications/CCL/Lisp code/midi-load.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-preliminaries.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-scaling.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-specific.lisp")
(load "//Applications/CCL/Lisp code/Pattern matching/SIA-redundant.lisp")

(progn
 (setq *scarlatti*
       (load-midi-file
        "/Users/tec69/Open/Conferences/ISMIR (International Society for Music Information Retrieval Conference)/2009/Music/Scarlatti-K3.mid"))
 (print "done"))
|#

(progn
  (setq dataset
        '(#|upbeat|#
  (3 76 69 1/4) (13/4 74 68 1/4) (7/2 72 67 1/4)
  (15/4 71 66 1/4)
  #|1|#
  (4 69 65 1) (5 64 62 1/4) (21/4 62 61 1/4)
  (11/2 60 60 1/4) (23/4 59 59 1/4) (6 57 58 1)
  (7 52 55 1/4) (29/4 50 54 1/4) (15/2 48 53 1/4)
  (31/4 47 52 1/4)
  #|2|#
  (8 45 51 1) (9 69 65 1) (10 64 62 1)
  (11 57 58 1) (11 72 67 1)
  #|3|#
  (12 52 55 1) (12 71 66 1) (13 60 60 1)
  (13 69 65 2) (14 59 59 2) (15 68 64 1)
  #|4|#
  (16 57 58 1) (17 72 67 1) (18 69 65 1)
  (19 60 60 1) (19 76 69 1)
  #|5|#
  (20 55 57 1) (20 74 68 1) (21 64 62 1)
  (21 72 67 2) (22 62 61 2) (23 71 66 1)
  #|6|#
  (24 60 60 1) (25 72 67 1) (26 67 64 1)
  (27 62 61 1) (27 77 70 1)
  #|7|#
  (28 57 58 1) (28 76 69 1) (29 65 63 1)
  (29 74 68 2) (30 64 62 2) (31 73 67 1)
  #|8|#
  (32 62 61 1) (33 74 68 1) (34 69 65 1)
  (35 64 62 1) (35 79 71 1)
  #|9|#
  (36 59 59 1) (36 78 70 1) (37 67 64 1)
  (37 76 69 2) (38 66 63 2) (39 75 68 1)
  #|10|#
  (40 64 62 2) (40 76 69 1/2) (81/2 74 68 1/2)
  (41 72 67 2) (42 63 61 1) (43 62 61 1)
  (43 71 66 2)
  #|11|#
  (44 61 60 1) (45 60 60 1) (45 69 65 2)
  (46 59 59 2) (47 67 64 2)
  #|12|#
  (48 58 58 1) (49 57 58 1) (49 66 63 2)
  (50 56 57 1) (51 55 57 1) (51 64 62 2)
  #|13|#
  (52 54 56 1) (53 53 56 1) (53 62 61 2)
  (54 52 55 2) (55 60 60 2)
  #|14|#
  (56 51 54 1) (57 50 54 1) (57 59 59  2)
  (58 49 53 1) (59 48 53 1) (59 57 58 2)
  #|15|#
  (60 47 52 2) (61 60 60 1) (62 63 61 1)
  (63 66 63 1)
  #|16|#
  (64 69 65 1) (65 72 67 1) (66 75 68 1)
  (67 78 70 1)
  #|17|#
  (68 81 72 1) (69 47 52 1) (69 84 74 2) (70 49 53 1)
  (71 51 54 1) (71 83 73 1/2) (143/2 81 72 1/2)
  #|18|#
  (72 52 55 1) (72 79 71 1) (73 53 56 1)
  (73 77 70 1) (74 55 57 2) (74 76 69 1)
  (75 74 68 1)
  #|19|#
  (76 55 57 1) (77 58 59 1) (78 61 60 1)
  (79 64 62 1)
  #|20|#
  (80 67 64 1) (81 70 66 1) (82 73 67 1)
  (83 76 69 1)
  #|21|#
  (84 79 71 1) (85 45 51 1) (85 82 73 2)
  (86 47 52 1) (87 49 53 1) (87 81 72 1/2)
  (175/2 79 71 1/2)
  #|22|#
  (88 50 54 1) (88 77 70 1) (89 52 55 1)
  (89 76 69 1) (90 53 56 2) (90 74 68 1)
  (91 72 67 1)
  #|23|#
  (92 53 56 1) (93 56 58 1) (94 59 59 1)
  (95 62 61 1)
  #|24|#
  (96 65 63 1) (97 68 65 1) (98 71 66 1)
  (99 74 68 1)
  #|25|#
  (100 77 70 1) (101 43 50 1) (101 80 72 2)
  (102 45 51 1) (103 47 52 1) (103 79 71 1/2)
  (207/2 77 70 1/2)
  #|26|#
  (104 48 53 1) (104 75 69 1) (105 50 54 1)
  (105 74 68 1) (106 51 55 1) (106 72 67 1)
  (107 53 56 1) (107 74 68 1)
  #|27|#
  (108 55 57 1) (108 67 64 1) (109 67 64 2)
  (109 71 66 1) (110 72 67 1) (111 53 56 1)
  (111 74 68 1)
  #|28|#
  (112 52 55 1) (112 67 64 1) (113 64 62 2)
  (113 71 66 1) (114 72 67 1) (115 50 54 1)
  (115 74 68 1)
  #|29|#
  (116 48 53 1) (116 64 62 1) (117 60 60 2)
  (117 71 66 1) (118 72 67 1) (119 47 52 1)
  (119 74 68 1)
  #|30|#
  (120 45 51 1) (120 60 60 1) (121 57 58 2)
  (121 71 66 1) (122 72 67 1) (123 43 50 1)
  (123 74 68 1)
  #|31|#
  (124 41 49 1) (124 57 58 1) (125 53 56 1)
  (125 59 59 1) (126 52 55 1) (126 60 60 1)
  (127 50 54 1) (127 62 61 1)
  #|32|#
  (128 48 53 1) (128 64 62 1) (129 50 54 1)
  (129 65 63 1) (130 52 55 1) (130 67 64 1)
  (131 53 56 1) (131 69 65 1)
  #|33|#
  (132 43 50 1) (132 71 66 1) (133 55 57 1)
  (133 69 65 1/2) (267/2 67 64 1/2) (134 52 55 1)
  (134 79 71 1) (135 53 56 1) (135 72 67 1)
  #|34|#
  (136 55 57 1) (136 72 67 5/4) (137 53 56 1)
  (549/4 71 66 1/4) (275/2 72 67 1/4) (551/4 74 68 1/4)
  (138 55 57 1) (138 74 68 3/2) (139 43 50 1)
  (279/2 72 67 1/2)
  #|35|#
  (140 48 53 2) (140 72 67 1) (141 84 74 1)
  (142 83 73 1) (143 82 73 1)
  #|36|#
  (144 81 72 1) (145 72 67 1) (145 80 72 2)
  (146 71 66 1) (147 70 66 1) (147 79 71 2) 
  #|37|#
  (148 69 65 1) (149 68 65 1) (149 77 70 2)
  (150 67 64 2) (151 75 69 2)
  #|38|#
  (152 66 63 1) (153 65 63 1) (153 74 68 2)
  (154 64 62 1) (155 63 62 1) (155 72 67 2)
  #|39|#
  (156 50 54 1) (157 62 61 1) (157 71 66 1)
  (158 60 60 1) (158 72 67 1) (159 59 59 1)
  (159 74 68 1)
  #|40|#
  (160 48 53 1) (160 64 62 1) (161 50 54 1)
  (161 65 63 1) (162 52 55 1) (162 67 64 1)
  (163 53 56 1) (163 69 65 1)
  #|41|#
  (164 43 50 1) (164 71 66 1) (165 55 57 1)
  (165 69 65 1/2) (331/2 67 64 1/2) (166 52 55 1)
  (166 79 71 1) (167 53 56 1) (167 72 67 1)
  #|42|#
  (168 55 57 1) (168 72 67 5/4) (169 53 56 1)
  (677/4 71 66 1/4) (339/2 72 67 1/4) (679/4 74 68 1/4)
  (170 55 57 1) (170 74 68 3/2) (171 43 50 1)
  (343/2 72 67 1/2)
  #|43|#
  (172 72 67 1) (173 79 71 1/4) (693/4 77 70 1/4)
  (347/2 76 69 1/4) (695/4 74 68 1/4) (174 72 67 1)
  (175 67 64 1/4) (701/4 65 63 1/4) (351/2 64 62 1/4)
  (703/4 62 61 1/4)
  #|44|#
  (176 60 60 1) (177 55 57 1/4) (709/4 53 56 1/4)
  (355/2 52 55 1/4) (711/4 50 54 1/4) (178 48 53 1)
  (179 43 50 1/4) (717/4 41 49 1/4) (359/2 40 48 1/4)
  (719/4 38 47 1/4)
  #|45|#
  (180 36 46 1) (181 48 53 1) (181 72 67 1)
  (182 67 64 1) (183 53 56 1) (183 69 65 1)
  (183 77 70 1)
  #|46|#
  (184 55 57 2) (184 67 64 2) (184 76 69 1) 
  (185 72 67 1) (186 43 50 2) (186 65 63 2)
  (186 74 68 1) (187 71 66 1)
  #|47|#
  (188 48 53 3) (188 64 62 3) (188 72 67 3)
  (191 79 71 1/4) (765/4 77 70 1/4)
  (383/2 76 69 1/4) (767/4 74 68 1/4)
  #|48|#
  (192 72 67 1) (193 67 64 1/4) (773/4 65 63 1/4)
  (387/2 64 62 1/4) (775/4 62 61 1/4) (194 60 60 1)
  (195 55 57 1/4) (781/4 53 56 1/4) (391/2 52 55 1/4)
  (783/4 50 54 1/4)
  #|49|#
  (196 48 53 1) (197 72 67 1) (198 67 64 1)
  (199 60 60 1) (199 75 69 1)
  #|50|#
  (200 62 61 2) (200 67 64 2) (200 75 69 1)
  (201 74 68 2) (202 50 54 2) (202 66 63 2)
  (203 72 67 1)
  #|51|#
  (204 55 57 2) (204 70 66 1) (205 74 68 1/4)
  (821/4 72 67 1/4) (411/2 70 66 1/4)
  (823/4 69 65 1/4) (206 67 64 1) (207 62 61 1/4)
  (829/4 60 60 1/4) (415/2 58 59 1/4)
  (831/4 57 58 1/4)
  #|52|#
  (208 55 57 1) (209 50 54 1/4) (837/4 48 53 1/4)
  (419/2 46 52 1/4) (839/4 45 51 1/4) (210 43 50 1)
  (211 55 57 1) (211 70 66 1) (211 79 71 1)
  #|53|#
  (212 57 58 2) (212 69 65 1) (212 79 71 1)
  (213 74 68 1) (213 77 70 1) (214 45 51 2)
  (214 74 68 1) (214 77 70 1) (215 73 67 1)
  (215 76 69 1)
  #|54|#
  (216 50 54 2) (216 74 68 1) (216 77 70 1)
  (217 81 72 1/4) (869/4 79 71 1/4) (435/2 77 70 1/4)
  (871/4 76 69 1/4) (218 74 68 1) (219 69 65 1/4)
  (877/4 67 64 1/4) (439/2 65 63 1/4)
  (879/4 64 62 1/4)
  #|55|#
  (220 62 61 1) (221 57 58 1/4) (885/4 55 57 1/4)
  (443/2 53 56 1/4) (887/4 52 55 1/4) (222 50 54 1)
  (223 45 51 1/4) (893/4 43 50 1/4) (447/2 41 49 1/4)
  (895/4 40 48 1/4)
  #|56|#
  (224 38 47 1) (225 74 68 1) (226 69 65 1)
  (227 62 61 1) (227 77 70 1)
  #|57|#
  (228 55 57 2) (228 70 66 2) (228 77 70 1)
  (229 76 69 1) (230 43 50 2) (230 70 66 2)
  (230 76 69 1) (231 74 68 1)
  #|58|#
  (232 45 51 2) (232 69 65 1) (232 73 67 1)
  (233 81 72 1) (234 80 71 1) (235 79 71 1)
  #|59|#
  (236 78 70 1) (237 69 65 1) (237 77 70 2)
  (238 68 64 1) (239 67 64 1) (239 76 69 2)
  #|60|#
  (240 66 63 1) (241 65 63 1) (241 74 68 2)
  (242 64 62 2) (243 72 67 2)
  #|61|#
  (244 63 61 1) (245 62 61 1) (245 71 66 2)
  (246 61 60 1) (247 60 60 1) (247 69 65 2)
  #|62|#
  (248 59 59 1) (249 58 59 1) (249 67 64 2)
  (250 57 58 2) (251 65 63 2)
  #|63|#
  (252 56 57 1) (253 55 57 1) (253 64 62 2)
  (254 54 56 1) (255 53 56 1) (255 62 61 2)
  #|64|#
  (256 40 48 2) (257 52 55 1) (258 56 57 1)
  (259 59 59 1)
  #|65|#
  (260 62 61 1) (261 65 63 1) (262 68 64 1)
  (263 71 66 1)
  #|66|#
  (264 74 68 1) (265 52 55 1) (265 77 70 2)
  (266 54 56 1) (267 56 57 1) (267 76 69 1/2)
  (535/2 74 68 1/2)
  #|67|#
  (268 57 58 1) (268 72 67 1) (269 59 59 1)
  (269 71 66 1) (270 60 60 2) (270 69 65 1)
  (271 67 64 1)
  #|68|#
  (272 54 56 1) (273 57 58 1) (274 60 60 1)
  (275 63 62 1)
  #|69|#
  (276 66 63 1) (277 69 65 1) (278 72 67 1)
  (279 75 69 1)
  #|70|#
  (280 84 74 3) (281 50 54 1) (282 52 55 1)
  (283 54 56 1) (283 82 73 1/2) (567/2 81 72 1/2)
  #|71|#
  (284 55 57 1) (284 82 73 1) (285 57 58 1) 
  (285 81 72 1) (286 58 59 2) (286 79 71 1)
  (287 77 70 1)
  #|72|#
  (288 64 62 1) (289 67 64 1) (290 70 66 1)
  (291 76 69 1)
  #|73|#
  (292 82 73 3) (293 48 53 1) (294 50 54 1)
  (295 52 55 1) (295 81 72 1/2) (591/2 80 71 1/2)
  #|74|#
  (296 53 56 2) (296 81 72 1) (297 79 71 2)
  (298 52 55 2) (299 77 70 1/2) (599/2 76 69 1/2)
  #|75|#
  (300 50 54 2) (300 77 70 1) (301 76 69 2)
  (302 48 53 2) (303 74 68 1/2) (607/2 73 67 1/2)
  #|76|#
  (304 47 52 2) (304 74 68 1) (305 72 67 2)
  (306 45 51 2) (307 71 66 1/2) (615/2 69 65 1/2)
  #|77|#
  (308 52 55 1) (308 68 64 1) (309 64 62 2)
  (309 80 71 1) (310 81 72 1) (311 50 54 1)
  (311 83 73 1)
  #|78|#
  (312 48 53 1) (312 76 69 1) (313 60 60 2)
  (313 80 71 1) (314 81 72 1) (315 47 52 1)
  (315 83 73 1)
  #|79|#
  (316 45 51 1) (316 72 67 1) (317 57 58 2) 
  (317 80 71 1) (318 81 72 1) (319 43 50 1)
  (319 83 73 1)
  #|80|#
  (320 41 49 1) (320 69 65 1) (321 53 56 2)
  (321 80 71 1) (322 81 72 1) (323 40 48 1)
  (323 83 73 1)
  #|81|#
  (324 38 47 1) (324 65 63 1) (325 62 61 1)
  (325 68 64 1) (326 60 60 1) (326 69 65 1)
  (327 59 59 1) (327 71 66 1)
  #|82|#
  (328 57 58 1) (328 72 67 1) (329 59 59 1)
  (329 74 68 1) (330 60 60 1) (330 76 69 1)
  (331 62 61 1) (331 77 70 1)
  #|83|#
  (332 52 55 1) (332 68 64 1) (333 62 61 1)
  (333 69 65 1/2) (667/2 71 66 1/2) (334 60 60 1)
  (334 64 62 1) (335 62 61 1) (335 74 68 1)
  #|84|#
  (336 64 62 1) (336 69 65 2) (336 72 67 1)
  (337 62 61 1) (337 74 68 1) (338 64 62 1)
  (338 68 64 2) (338 71 66 2) (339 52 55 1)
  #|85|#
  (340 69 65 1) (341 81 72 1) (342 80 71 1)
  (343 79 71 1)
  #|86|#
  (344 78 70 1) (345 69 65 1) (345 77 70 2)
  (346 68 64 1) (347 67 64 1) (347 76 69 2)
  #|87|#
  (348 66 63 1) (349 65 63 1) (349 74 68 2)
  (350 64 62 2) (351 72 67 2)
  #|88|#
  (352 63 61 1) (353 62 61 1) (353 71 66 2)
  (354 61 60 1) (355 60 60 1) (355 69 65 2)
  #|89|#
  (356 59 59 2) (356 62 61 2) (357 68 64 1)
  (358 57 58 1) (358 60 60 1) (358 69 65 1)
  (359 50 54 1) (359 74 68 1)
  #|90|#
  (360 52 55 1) (360 64 62 2) (360 69 65 2)
  (360 72 67 1) (361 50 54 1) (361 74 68 1)
  (362 52 55 1) (362 68 64 2) (362 71 66 2)
  (363 40 48 1)
  #|91|#
  (364 45 51 2) (364 69 65 1) (365 76 69 1/4)
  (1461/4 74 68 1/4) (731/2 72 67 1/4)
  (1463/4 71 66 1/4) (366 69 65 1)
  (367 64 62 1/4) (1469/4 62 61 1/4)
  (735/2 60 60 1/4) (1471/4 59 59 1/4)
  #|92|#
  (368 57 58 1) (369 52 55 1/4) (1477/4 50 54 1/4)
  (739/2 48 53 1/4) (1479/4 47 52 1/4)
  (370 45 51 1) (371 50 54 1) (371 65 63 1)
  (371 69 65 1) (371 74 68 1)
  #|93|#
  (372 52 55 2) (372 64 62 2) (372 69 65 2)
  (372 72 67 2) (374 40 48 2) (374 64 62 2)
  (374 68 64 2) (374 71 66 2)
  #|94|#
  (376 45 51 3) (376 69 65 3)))

  (print "Large dataset defined"))