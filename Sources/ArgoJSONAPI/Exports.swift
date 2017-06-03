@_exported import Argo
@_exported import Runes

// Redeclare Runes operators
infix operator <^> : RunesApplicativePrecedence
infix operator <*> : RunesApplicativePrecedence
infix operator <* : RunesApplicativeSequencePrecedence
infix operator *> : RunesApplicativeSequencePrecedence
infix operator <|> : RunesAlternativePrecedence
infix operator >>- : RunesMonadicPrecedenceLeft
infix operator -<< : RunesMonadicPrecedenceRight
infix operator >-> : RunesMonadicPrecedenceRight
infix operator <-< : RunesMonadicPrecedenceRight

// Redeclare Argo operators
infix operator <| : ArgoDecodePrecedence
infix operator <|? : ArgoDecodePrecedence
infix operator <|| : ArgoDecodePrecedence
infix operator <||? : ArgoDecodePrecedence
