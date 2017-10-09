;; -*- mode: scheme; coding: utf-8 -*-
;; Copyright © 2017 Göran Weinholt <goran@weinholt.se>
;; SPDX-License-Identifier: GPL-3.0+

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
#!r6rs

(library (akku lib git)
  (export
    is-git-repository?
    git-shallow-clone
    git-fetch
    git-fetch-tag
    git-checkout-commit
    git-checkout-branch
    git-checkout-tag
    git-ls-files)
  (import
    (akku lib compat)
    (only (akku lib utils) string-split)
    (rnrs (6)))

(define (is-git-repository? dir)
  (file-directory? (string-append dir "/.git")))

(define (git-shallow-clone directory repository)
  (putenv "GIT_DIR" ".git")
  (putenv "AKKU_DIR" directory)
  (putenv "AKKU_REPO" repository)
  (assert (zero? (system "set -x;git clone --single-branch --depth=1 -q \"$AKKU_REPO\" \"$AKKU_DIR\""))))

(define (git-fetch directory commit)
  (putenv "GIT_DIR" ".git")
  (putenv "AKKU_DIR" directory)
  (putenv "AKKU_COMMIT" commit)
  (assert (zero? (system "set -x;cd \"$AKKU_DIR\" && git fetch --depth=1 -q origin \"$AKKU_COMMIT\""))))

(define (git-fetch-tag directory tag)
  (putenv "GIT_DIR" ".git")
  (putenv "AKKU_DIR" directory)
  (putenv "AKKU_TAG" tag)
  (assert (zero? (system "set -x;cd \"$AKKU_DIR\" && git fetch --depth=1 -q --tags origin \"refs/tags/$AKKU_TAG\""))))

(define (git-checkout-commit directory commit)
  (putenv "GIT_DIR" ".git")
  (putenv "AKKU_DIR" directory)
  (putenv "AKKU_COMMIT" commit)
  (assert (zero? (system "set -x;cd \"$AKKU_DIR\" && git checkout --detach -q \"$AKKU_COMMIT\""))))

(define (git-checkout-branch directory branch)
  (git-checkout-commit directory branch))

(define (git-checkout-tag directory tag)
  (git-checkout-commit directory tag))

(define (git-ls-files directory)
  (putenv "GIT_DIR" ".git")
  (putenv "AKKU_DIR" directory)
  (let-values (((from-stdin to-stdin _process-id)
                (apply values (process "cd \"$AKKU_DIR\" && git ls-files -z"))))
    (close-port to-stdin)
    (let ((output (get-string-all from-stdin)))
      (filter (lambda (x) (> (string-length x) 0))
              (string-split output #\nul))))))
