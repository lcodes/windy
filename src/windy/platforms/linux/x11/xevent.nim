import vmath, x, xlib

type
  IfEventProc* = proc (
    d: Display,
    event: ptr XEvent,
    p: pointer
  ): bool {.cdecl.}
  ErrorHandleProc* = proc (d: Display, event: ptr XErrorEvent): bool {.cdecl.}

  XEventKind* {.size: cint.sizeof.} = enum
    xeKeyPress = 2
    xeKeyRelease = 3
    xeButtonPress = 4
    xeButtonRelease = 5
    xeMotion = 6
    xeEnter = 7
    xeLeave = 8
    xeFocusIn = 9
    xeFocusOut = 10
    xeKeymap = 11
    xeExpose = 12
    xeGraphicsExpose = 13
    xeNoExpose = 14
    xeVisibility = 15
    xeCreate = 16
    xeDestroy = 17
    xeUnmap = 18
    xeMap = 19
    xeMapRequest = 20
    xeReparent = 21
    xeConfigure = 22
    xeConfigureRequest = 23
    xeGravity = 24
    xeResizeRequest = 25
    xeCirculate = 26
    xeCirculateRequest = 27
    xeProperty = 28
    xeSelectionClear = 29
    xeSelectionRequest = 30
    xeSelection = 31
    xeColormap = 32
    xeClientMessage = 33
    xeMapping = 34
    xeGenericEvent = 35

  XKeyEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: cint
    display*: Display
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    pos*: IVec2
    rootPos*: IVec2
    state*: cuint
    keycode*: cuint
    same_screen*: cint

  XButtonEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: cint
    display*: Display
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    pos*: IVec2
    rootPos*: IVec2
    state*: cuint
    button*: cuint
    same_screen*: cint

  XMotionEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: cint
    display*: Display
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    pos*: IVec2
    rootPos*: IVec2
    state*: cuint
    is_hint*: cchar
    same_screen*: cint

  XCrossingEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: cint
    display*: Display
    window*: Window
    root*: Window
    subwindow*: Window
    time*: Time
    pos*: IVec2
    rootPos*: IVec2
    mode*: cint
    detail*: cint
    same_screen*: bool
    focus*: bool
    state*: cuint

  XFocusChangeEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    mode*: cint
    detail*: cint

  XKeymapEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    key_vector*: array[0..31, cchar]

  XExposeEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    pos*: IVec2
    size*: IVec2
    count*: cint

  XGraphicsExposeEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    drawable*: Drawable
    pos*: IVec2
    size*: IVec2
    count*: cint
    major_code*: cint
    minor_code*: cint

  XNoExposeEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    drawable*: Drawable
    major_code*: cint
    minor_code*: cint

  XVisibilityEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    state*: cint

  XCreateWindowEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    parent*: Window
    window*: Window
    pos*: IVec2
    size*: IVec2
    border_width*: cint
    override_redirect*: bool

  XDestroyWindowEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    event*: Window
    window*: Window

  XUnmapEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    event*: Window
    window*: Window
    from_configure*: bool

  XMapEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    event*: Window
    window*: Window
    override_redirect*: bool

  XMapRequestEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    parent*: Window
    window*: Window

  XReparentEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    event*: Window
    window*: Window
    parent*: Window
    pos*: IVec2
    override_redirect*: bool

  XConfigureEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    event*: Window
    window*: Window
    pos*: IVec2
    size*: IVec2
    border_width*: cint
    above*: Window
    override_redirect*: bool

  XGravityEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    event*: Window
    window*: Window
    pos*: IVec2

  XResizeRequestEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    size*: IVec2

  XConfigureRequestEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    parent*: Window
    window*: Window
    pos*: IVec2
    size*: IVec2
    border_width*: cint
    above*: Window
    detail*: cint
    value_mask*: culong

  XCirculateEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    event*: Window
    window*: Window
    place*: cint

  XCirculateRequestEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    parent*: Window
    window*: Window
    place*: cint

  XPropertyEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    atom*: Atom
    time*: Time
    state*: cint

  XSelectionClearEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    selection*: Atom
    time*: Time

  XSelectionRequestEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    owner*: Window
    requestor*: Window
    selection*: Atom
    target*: Atom
    property*: Atom
    time*: Time

  XSelectionEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    requestor*: Window
    selection*: Atom
    target*: Atom
    property*: Atom
    time*: Time

  XColormapEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    colormap*: Colormap
    c_new*: bool
    state*: cint

  XClientMessageData* {.union.} = object
    b*: array[20, cchar]
    s*: array[10, cshort]
    l*: array[5, clong]

  XClientMessageEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    message_type*: Atom
    format*: cint
    data*: XClientMessageData

  XMappingEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window
    request*: cint
    first_keycode*: cint
    count*: cint

  XErrorEvent* = object
    kind*: XEventKind
    display*: Display
    resourceid*: XID
    serial*: culong
    error_code*: char
    request_code*: char
    minor_code*: char

  XAnyEvent* = object
    kind*: XEventKind
    serial*: culong
    send_event*: bool
    display*: Display
    window*: Window

  XGenericEvent* = object
    kind*: XEventKind ## Type of event. Always GenericEvent
    serial*: culong   ## Serial number of last request processed
    send_event*: bool ## true if from SendEvent request
    display*: Display ## Display the event was read from
    extension*: cint  ## major opcode of extension that caused the event
    evtype*: cint     ## actual event type.

  XGenericEventCookie* = object
    kind*: XEventKind ## Type of event. Always GenericEvent
    serial*: culong   ## Serial number of last request processed
    send_event*: bool ## true if from SendEvent request
    display*: Display ## Display the event was read from
    extension*: cint  ## major opcode of extension that caused the event
    evtype*: cint     ## actual event type.
    cookie*: cuint
    data*: pointer

  XEvent* {.union.} = object
    kind*: XEventKind
    any*: XAnyEvent
    key*: XKeyEvent
    button*: XButtonEvent
    motion*: XMotionEvent
    crossing*: XCrossingEvent
    focus*: XFocusChangeEvent
    expose*: XExposeEvent
    graphicsexpose*: XGraphicsExposeEvent
    noexpose*: XNoExposeEvent
    visibility*: XVisibilityEvent
    createwindow*: XCreateWindowEvent
    destroywindow*: XDestroyWindowEvent
    unmap*: XUnmapEvent
    map*: XMapEvent
    maprequest*: XMapRequestEvent
    reparent*: XReparentEvent
    configure*: XConfigureEvent
    gravity*: XGravityEvent
    resizerequest*: XResizeRequestEvent
    configurerequest*: XConfigureRequestEvent
    circulate*: XCirculateEvent
    circulaterequest*: XCirculateRequestEvent
    property*: XPropertyEvent
    selectionclear*: XSelectionClearEvent
    selectionrequest*: XSelectionRequestEvent
    selection*: XSelectionEvent
    colormap*: XColormapEvent
    client*: XClientMessageEvent
    mapping*: XMappingEvent
    error*: XErrorEvent
    keymap*: XKeymapEvent
    xgeneric*: XGenericEvent
    cookie*: XGenericEventCookie
    pad: array[0..23, clong]

{.push, cdecl, dynlib: libX11, importc.}

proc XCheckIfEvent*(d: Display; e: ptr XEvent, cb: IfEventProc,
    userData: pointer): bool
proc XSendEvent*(d: Display; window: Window, propogate: bool, mask: clong, e: ptr XEvent)

proc Xutf8LookupString*(ic: XIC, e: ptr XKeyEvent, buffer: cstring, len: cint,
    ks: ptr KeySym, status: ptr cint): cint

proc XSetErrorHandler*(handler: ErrorHandleProc)

proc XLookupKeysym*(e: ptr XKeyEvent, i: cint): KeySym

proc XNextEvent*(d: Display, event: ptr XEvent)

{.pop.}
