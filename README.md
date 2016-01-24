# pandoc-moreblock-filter

## Why this filter?

When you write a lecture (esp. a math lecture) in Markdown and use pandoc to create a 
LaTeX or LaTeX-beamer output, you might want not only blocks, but have control over the 
type of blocks pandoc adds.

## What does it do for you?

Take a look at the following input:

    ### from Vieta {.theorem}
  
    For a polynom $x^2+px+q$ with zeros $x_1$ and $x_2$, the formulars 
    $p = -(x_1+x_2)$ and $q=x_1 \cdot x_2$ always holds.
  

Normally this would lead to the following output:

	\begin{block}{from Vieta}
	For a polynom $x^2+px+q$ with zeros $x_1$ and $x_2$, the formulars 
	$p = -(x_1+x_2)$ and $q=x_1 \cdot x_2$ always holds.
	\end{block}

Using the pandoc-moreblock-filter, we map the option {.theorem} to the amslatex enviroment
"\begin{theorem}...\end{theorem}" instead. so we get the output:

    \begin{theorem}[from Vieta]
    For a polynom $x^2+px+q$ with zeros $x_1$ and $x_2$, the formulars 
	$p = -(x_1+x_2)$ and $q=x_1 \cdot x_2$ always holds.
    \end{theorem}

as an output. 

With the {.endblock} option it is even possible to end a block at will.
So the input 

    ### from Vieta {.theorem}
  
    For a polynom $x^2+px+q$ with zeros $x_1$ and $x_2$, the formulars 
    $p = -(x_1+x_2)$ and $q=x_1 \cdot x_2$ always holds.
  
    ### {.endblock}
    
    We can use this theorem to guess a root of a polynom where p and q are integers. 
  
    ###  {.corollar}
  
    A root must allways be a divisor of $q$!

will lead to the output

    \begin{theorem}[from Vieta]
    For a polynom $x^2+px+q$ with zeros $x_1$ and $x_2$, the formulars 
    $p = -(x_1+x_2)$ and $q=x_1 \cdot x_2$ always holds.
    \end{theorem}

    We can use this theorem to guess a root of a polynom where p and q are integers. 
  
    \begin{corollar}
	A root must allways be a divisor of $q$!
    \end{corollar}
	
## How to use it with pandoc

Using this filter is easy, if you got a sufficent Haskell compiler running, for example 
the GHC. 

To test the filter you might use

> pandoc -t json **test.md** | runhaskell moreblocks.hs | pandoc -t beamer -r json

or, if you have a (pre-)compiled version of the filter named "moreblocks", you might use

> pandoc -t beamer --filter moreblocks **test.md**
 
instead.

## How does it work?

Simple! - The filter seaches for a "{.theorem}", "{.example}", "{.examples}", "{.fact}", 
... ,or "{.noblock}" option in the Markdown block "###", just like in the example above.
This is replaced by a RawLatexBlock or RawLatexInline with "\begin{Satz}...\end{Satz}",
"\begin{Beispiel}...\end{Beispiel}", "\begin{Beispiele}...\end{Beispiele}"

You might change the options name in "moreblocks.hs". This all interacts with the 
"moreblocks.tex" file in wich all new blocks are defined and the color is set. 

## Okay, I do need more help!

Feel free to ask me. Send a message to nmarkgraf (at) hotmail (dot) com with the 
subject "pandoc-moreblocks-filter", and I tried to help you asap!


## Releases

- Release 1.0 nm (05.06.2015) 
	Initial Concept. Better to say a proof of concept.
- Release 1.1 nm (05.06.2015) 
	First real good release. At least it does the job
- Release 1.2 nm (24.01.2015) 
	Added {.notblock} option and updated the README.md, so this might get useful 
	to others too.
							
