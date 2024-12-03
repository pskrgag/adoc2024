import Data.Char
import Data.Maybe

parseInt :: String -> Maybe (Int, String)
parseInt (x : xs) =
  let helper (x : xs) acc
        | isNumber x = helper xs (acc * 10 + ord x - 48)
        | otherwise = (acc, x : xs)
      helper [] acc = (acc, [])
   in if isNumber x then Just $ helper (x : xs) 0 else Nothing

parse :: String -> Int -> Int
parse [] acc = acc
parse (x : xs) acc = case x : xs of
  ('m' : 'u' : 'l' : '(' : others) ->
    fromMaybe
      (parse others acc)
      ( do
          (val, x1 : xs1) <- parseInt others
          (val1, x2 : xs2) <- if x1 == ',' then parseInt xs1 else Nothing
          (val2, xs3) <- if x2 == ')' then Just (val1, xs2) else Nothing
          return $ parse xs2 (acc + (val2 * val))
      )
  (x : xs) -> parse xs acc

main1 = do
  s <- readFile "input"
  print $ parse s 0
