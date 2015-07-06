;;; ejis.el -- formatting settings for java-mode

;; Copyright (C) 2015 Łukasz Klich

;; Author: Lukasz Klich <klich.lukasz@gmail.com>
;; Created: 05 Jul 2007
;; Version: 0.0.1
;; Keywords: tools, java
;; Package-Requires: ()

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code

(require 'cc-mode)

(defconst ejis--intellij-java-style
  '((c-basic-offset . 4)
    (c-comment-only-line-offset . (0 . 0))
    ;; the following preserves Javadoc starter lines
    (c-offsets-alist . ((inline-open . 0)
                        (topmost-intro-cont    . +)
                        (statement-block-intro . +)
                        (knr-argdecl-intro     . 5)
                        (substatement-open     . +)
                        (substatement-label    . +)
                        (label                 . +)
                        (statement-case-open   . +)
                        (case-label            . +)
                        (statement-cont        . ++)
                        (arglist-intro         . c-lineup-arglist-intro-after-paren)
                        (arglist-close         . c-lineup-arglist)
                        (access-label          . 0)
                        (inher-cont            . c-lineup-java-inher)
                        (func-decl-cont        . c-lineup-java-throws)
                        (arglist-cont-nonempty . ejis--arglist-cont-nonempty)
                        )))
  "Intellij Java Programming Style")

(c-add-style "IntelliJ" ejis--intellij-java-style)

(defun ejis--function-declaration? (pos)
  (save-excursion
    (goto-char pos)
    (--any (eq (c-langelem-sym it) 'topmost-intro)
           (c-guess-basic-syntax))))

(defun ejis--arglist-cont-nonempty (arg)
  (if (ejis--function-declaration? (c-langelem-pos arg))
      (c-lineup-arglist arg))
    (progn
      (* 2  c-basic-offset)))

(provide 'ejis)
;;; ejis.el ends here
