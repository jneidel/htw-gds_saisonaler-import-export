# Latex Styleguide

## Citations

```tex
% given this source in bibliography:
% @book{twoBits,
%   author = {Christopher M. Kelty},
%   date = {2008},
%   title = {Two Bits: the Cultural Significance of Free Software},
% }


\textcite{twoBits} % => Christopher M. Kelty (2008)
% use in text

\cite{twoBits} % => Christopher M. Kelty 2008
\cite[28]{twoBits} % => Christopher M. Kelty 2008, p. 28
% use after direct quote

\parencite{twoBits} % => (Christopher M. Kelty 2008)
\parencite[Vgl.][28]{twoBits} % => (Vgl. Christopher M. Kelty 2008, p. 28)
% use at the end of text

\autocite{twoBits} % => ^1 (squared one, and a footnote with normal \cite)
% use if would be too big (webpages)
```

Creating a bibliography entry and more on quotes: [biber introduction](https://en.wikibooks.org/wiki/LaTeX/Bibliographies_with_biblatex_and_biber)

## Quotes

```tex
% citations with corret quotes:
``this is a quote" or a `specific phrase'
% instead of the wrong "this is a quote" or a 'specific phrase'
```

Output of wrong quotes: ![](https://i.imgur.com/NZOdoiG.png)

Output of correct quotes: ![](https://i.imgur.com/rkB7vLH.png)

## Text breaks

To separate two blocks of text use `\medskip`.

## Sections

There are different level of sections:
- `\section` is the top level section (e.g. 2.)
- `\subsection` is a nested section (e.g. 2.1.)
- `\subsubsection` is a nested a level deeper (e.g. 2.1.3.)
- etc.

## Images

- [How to insert images](https://www.overleaf.com/learn/latex/Inserting_Images)
