;;; etest-execute.el --- Help the user run tests.

;; Copyright (C) 2008 Philip Jackson

;; Author: Philip Jackson <phil@shellarchive.co.uk>

;; This file is not currently part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program ; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This file will aid the execution of a test run.

(make-variable-buffer-local
 (defvar etest-file nil
  "The path of the etest file associated with the current buffer."))

(make-variable-buffer-local
 (defvar etest-load-path "~/.etests"
  "The path of the etest load path."))

(defun etest-execute-get-test-file ()
  "Find a test file by first checking the (buffer local) variable
`etest-file' then checking `etest-load-path' for a similarly
named (to the buffer) file."
  (cond
    ((and etest-file
          (file-exists-p (expand-file-name etest-file)))
     (expand-file-name etest-file))
    ((when etest-load-path
       (catch 'found
         (let ((name (concat
                      (file-name-sans-extension
                       (file-name-nondirectory buffer-file-name)) ".etest")))
           (mapc '(lambda (d)
                   (let ((name (expand-file-name (concat d name))))
                     (when (file-exists-p name)
                       (throw 'found name))))
                 etest-load-path)))))))
               

(defun etest-execute ()
  (interactive))


(provide 'etest-execute)
