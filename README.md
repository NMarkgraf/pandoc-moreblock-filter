# pandoc-moreblock-filter

When you write a lecture (esp. a math lecture) in Markdown and use pandoc to create a LaTeX or LaTeX-beamer output, you might want not only blocks, but have control over the type of blocks pandoc adds.

With something like

    ### from Vieta {.theorem}
  
    For a polynom $x^2+px+q$ with zeros $x_1$ and $x_2$, the formulars 
    $p = -(x_1+x_2)$ and $q=x_1 \cdot x_2$ always holds.
  

you get 

    \begin{theorem}
      For a polynom $x^2+px+q$ with zeros $x_1$ and $x_2$, the formulars 
      $p = -(x_1+x_2)$ and $q=x_1 \cdot x_2$ always holds.
    \end{theorem}

as an output.

