{$IFNDEF VER80}     		    // DELPHI 1.0
  {$IFNDEF VER90}                   // DELPHI 2.0
    {$IFNDEF VER93}                 // C++Builder 1.0

      {$IFDEF VER100}               // Delphi 3.0
        {$DEFINE Delphi3_Or_Higher}
        {$DEFINE Version3_Or_Higher}  // Delphi 3 or C++Builder 3 or Higher
        {$DEFINE Delphi3}
      {$ENDIF}

      {$IFDEF VER110}               // C++Bulder 3.0
        {$DEFINE Version3_Or_Higher}  // Delphi 3 or C++Builder 3 or Higher
        {$DEFINE Builder3}
        {$DEFINE Builder}
      {$ENDIF}

      {$IFDEF VER120}               // Delphi 4.0
        {$DEFINE Delphi4}
        {$DEFINE Delphi3_Or_Higher}
        {$DEFINE Delphi4_Or_Higher}
        {$DEFINE Version4_Or_Higher}
        {$DEFINE Version3_Or_Higher}  // Delphi 3 or C++Builder 3 or Higher
      {$ENDIF}

      {$IFDEF VER125}              // C++Bulder 4.0
        {$DEFINE Version4_Or_Higher}
        {$DEFINE Version3_Or_Higher}  // Delphi 3 or C++Builder 3 or Higher
        {$DEFINE Builder4}
        {$DEFINE Builder3}
        {$DEFINE Builder}
      {$ENDIF}

      {$IFDEF VER130}
        {$DEFINE Delphi5}           // Delphi 5.0
        {$DEFINE Delphi3_Or_Higher}
        {$DEFINE Delphi4_Or_Higher}
        {$DEFINE Version4_Or_Higher}
        {$DEFINE Version3_Or_Higher}  // Delphi 3 or C++Builder 3 or Higher
      {$ENDIF}

      {$IFDEF VER140}
        {$DEFINE Delphi6}           // Delphi 6.0
        {$DEFINE Delphi5}
        {$DEFINE Delphi3_Or_Higher}
        {$DEFINE Delphi4_Or_Higher}
        {$DEFINE Version4_Or_Higher}
        {$DEFINE Version3_Or_Higher}  // Delphi 3 or C++Builder 3 or Higher
      {$ENDIF}

      {$IFDEF VER145}
        {$DEFINE Builder6}           // C++Builder 6.0
        {$DEFINE Builder5}
        {$DEFINE Builder4}
        {$DEFINE Builder3}
        {$DEFINE Version6_Or_Higher}  // Delphi 6 or C++Builder 6 or Higher
        {$DEFINE Version5_Or_Higher}  // Delphi 5 or C++Builder 5 or Higher
        {$DEFINE Version4_Or_Higher}
        {$DEFINE Version3_Or_Higher}  // Delphi 3 or C++Builder 3 or Higher
      {$ENDIF}


      {$IFDEF VER150}
        {$DEFINE Delphi7}           // Delphi 7.0
        {$DEFINE Delphi6}           
        {$DEFINE Delphi5}
        {$DEFINE Delphi3_Or_Higher}
        {$DEFINE Delphi4_Or_Higher}
        {$DEFINE Version4_Or_Higher}
        {$DEFINE Version3_Or_Higher}  // Delphi 3 or C++Builder 3 or Higher
      {$ENDIF}

    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER93}
  {$DEFINE Builder}
{$ENDIF}

{$IFDEF Builder3}
  {$ObjExportAll On}
{$ENDIF}


{$IFDEF Delphi7}
  {$IFNDEF WIN32}
  {$Message Fatal 'NTSet is developed for Win32 platform'}
  {$ENDIF}

  // we know we do pointer typecasting.
  {$WARN UNSAFE_CAST OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CODE OFF}

  {$TYPEDADDRESS OFF}  // do produce warnings when using @ operator
  
{$ENDIF}




