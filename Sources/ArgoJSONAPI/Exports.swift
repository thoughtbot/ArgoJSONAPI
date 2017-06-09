#if SWIFT_PACKAGE
@_exported import Argo
#else
import Argo
#endif

infix operator <| : ArgoDecodePrecedence
infix operator <|? : ArgoDecodePrecedence
infix operator <|| : ArgoDecodePrecedence
infix operator <||? : ArgoDecodePrecedence
