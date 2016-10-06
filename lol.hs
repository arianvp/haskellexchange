 {-# LANGUAGE RankNTypes #-}
 {-# LANGUAGE UnicodeSyntax #-}

class P f where d∷(a→b)→(c→d)→f a c→f b d
class P f⇒S f where{f∷f a b→f(a,c)(b,c);s∷f b c→f(a,c)(b,c)}
type L s t a b=∀ p.S p⇒p a b→p s t
