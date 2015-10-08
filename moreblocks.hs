{-# LANGUAGE OverloadedStrings #-}
module Main where

-- moreblocks.hs

import Text.Pandoc.JSON
import Text.Pandoc.Shared
import Text.Pandoc.Walk
import Text.Pandoc.Definition
import Text.Printf
import Data.Maybe

specialHeader :: Pandoc -> Pandoc
specialHeader (Pandoc meta blocks) = Pandoc meta (elemToBlock $ hierarchicalize blocks)

elemToBlock :: [Element] -> [Block]
elemToBlock (Blk b:xs) = b : elemToBlock xs
elemToBlock (Sec 4 num attr@(_,classes,_) label contents:xs) 
	| (elem "theorem" classes) = theorem  
	| (elem "example" classes) = example  
	| (elem "examples" classes) = examples  
	| (elem "definition" classes) = definition
	| (elem "proof" classes) = proof
	| (elem "lemma" classes) = lemma  
	| (elem "remark" classes) = remark  	
	| (elem "remarks" classes) = remarks  	
	| (elem "exercise" classes) = exercise  	
	| (elem "solution" classes) = solution  	
	| (elem "fact" classes) = fact  	
	| (elem "facts" classes) = facts  	
	where
		theorem 	= Plain ([mkEnv "Satz"]    		++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Satz"   		: elemToBlock xs
		example 	= Plain ([mkEnv "Beispiel"]    	++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Beispiel"    	: elemToBlock xs
		examples 	= Plain ([mkEnv "Beispiele"]   	++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Beispiele"    	: elemToBlock xs
		definition 	= Plain ([mkEnv "definition"] 	++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "definition" 	: elemToBlock xs
		proof 		= Plain ([mkEnv "Beweis"]      	++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Beweis"      	: elemToBlock xs
		lemma 		= Plain ([mkEnv "Lemma"]     	++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Lemma"      	: elemToBlock xs
		remark 		= Plain ([mkEnv "Bemerkung"]    ++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Bemerkung"   	: elemToBlock xs
		remarks 	= Plain ([mkEnv "Bemerkungen"] 	++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Bemerkungen" 	: elemToBlock xs
		exercise 	= Plain ([mkEnv "Uebung"]    	++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Uebung"      	: elemToBlock xs
		solution 	= Plain ([mkEnv "Loesung"]    	++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Loesung"      	: elemToBlock xs
		fact 		= Plain ([mkEnv "Fakt"]   	 	++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Fakt"      		: elemToBlock xs
		facts 		= Plain ([mkEnv "Fakten"]   	 ++ label ++ [endLabel]) : elemToBlock contents ++ closeEnv "Fakten"      		: elemToBlock xs
elemToBlock (Sec lvl num attributes label contents:xs) = Header lvl attributes label : elemToBlock contents ++ elemToBlock xs
elemToBlock [] = []

mkEnv :: String -> Inline
mkEnv typ = RawInline "latex" $ printf "\\begin{%s}[" typ

closeEnv :: String -> Block
closeEnv typ = RawBlock "latex" $ printf "\\end{%s}" typ

endLabel :: Inline
endLabel = RawInline "latex" "]"

main :: IO ()
main = toJSONFilter specialHeader
        
