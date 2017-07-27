module MessageTypes exposing (Msg(..))

import Window

type Msg
    = JustDebug
    | Resize Window.Size
