

{ NOTE: this is an _abbreviated_ version of image.inc created specifically    }
{       for the program that is using it.                                     }


{ --------------------------------------------------------------------------- }
{ DOS HEADER related types and constants                                      }

const
  IMAGE_DOS_SIGNATURE = $5a4d;                        { 'MZ'                  }

{$ifndef MS_FIELD_NAMES}
type
  { _IMAGE_DOS_HEADER                                                         }

  PIMAGE_DOS_HEADER   = ^TIMAGE_DOS_HEADER;
  TIMAGE_DOS_HEADER   = packed record
    Signature              : word;
    BytesOnLastPage        : word;
    PageCount              : word;
    RelocationsCount       : word;
    HeaderInParagraphs     : word;
    ExtraParagraphsNeeded  : word;
    MaximumMemory          : word;
    InitialSS              : word;
    InitialSP              : word;
    Checksum               : word;
    InitialIp              : word;
    InitialCs              : word;
    RelocationsTableOffset : word;
    OverlayNumber          : word;
    ReservedWordsA         : packed array[0..3] of word;
    OEMidentifier          : word;
    OEMinformation         : word;
    ReservedWordsB         : packed array[0..9] of word;
    OffsetToNewExecutable  : DWORD;
  end;
{$endif}


{$ifdef MS_FIELD_NAMES}                               {  winnt.h field names  }
type
  { _IMAGE_DOS_HEADER                                                         }

  PIMAGE_DOS_HEADER   = ^TIMAGE_DOS_HEADER;
  TIMAGE_DOS_HEADER   = packed record
    e_magic                : word;
    e_cblp                 : word;
    e_cp                   : word;
    e_crlc                 : word;
    e_cparhdr              : word;
    e_minalloc             : word;
    e_maxalloc             : word;
    e_ss                   : word;
    e_sp                   : word;
    e_csum                 : word;
    e_ip                   : word;
    e_cs                   : word;
    e_lfarlc               : word;
    e_ovno                 : word;
    e_res                  : packed array[0..3] of word;
    e_oemid                : word;
    e_oeminfo              : word;
    e_res2                 : packed array[0..9] of word;
    e_lfanew               : DWORD;
  end;
{$endif}


{ --------------------------------------------------------------------------- }
{ IMAGE FILE HEADER related types and constants                               }

const
  { Machine field                                                             }

  IMAGE_FILE_MACHINE_UNKNOWN       =     0;


  IMAGE_FILE_MACHINE_TARGET_HOST   =    $1; { Useful for indicating we want to}
                                            { interact with the host and not a}
                                            { WoW guest.                      }


  IMAGE_FILE_MACHINE_I386          =  $14c; { Intel 386.                      }

  IMAGE_FILE_MACHINE_R3000         =  $162; { MIPS little-endian,             }
                                            { = $160 big-endian               }

  IMAGE_FILE_MACHINE_R4000         =  $166; { MIPS little-endian              }
  IMAGE_FILE_MACHINE_R10000        =  $168; { MIPS little-endian              }
  IMAGE_FILE_MACHINE_WCEMIPSV2     =  $169; { MIPS little-endian WCE v2       }

  IMAGE_FILE_MACHINE_ALPHA         =  $184; { Alpha_AXP                       }

  IMAGE_FILE_MACHINE_SH3           =  $1a2; { SH3 little-endian               }
  IMAGE_FILE_MACHINE_SH3DSP        =  $1a3;
  IMAGE_FILE_MACHINE_SH3E          =  $1a4; { SH3E little-endian              }
  IMAGE_FILE_MACHINE_SH4           =  $1a6; { SH4 little-endian               }
  IMAGE_FILE_MACHINE_SH5           =  $1a8; { SH5                             }

  IMAGE_FILE_MACHINE_ARM           =  $1c0; { ARM Little-Endian               }
  IMAGE_FILE_MACHINE_THUMB         =  $1c2;
  IMAGE_FILE_MACHINE_ARMNT         =  $1c4; { ARM Thumb-2 Little-Endian       }

  IMAGE_FILE_MACHINE_AM33          =  $1d3;
  IMAGE_FILE_MACHINE_POWERPC       =  $1F0; { IBM PowerPC Little-Endian       }
  IMAGE_FILE_MACHINE_POWERPCFP     =  $1f1;
  IMAGE_FILE_MACHINE_IA64          =  $200; { Intel 64                        }
  IMAGE_FILE_MACHINE_MIPS16        =  $266; { MIPS                            }
  IMAGE_FILE_MACHINE_ALPHA64       =  $284; { ALPHA64                         }
  IMAGE_FILE_MACHINE_MIPSFPU       =  $366; { MIPS                            }
  IMAGE_FILE_MACHINE_MIPSFPU16     =  $466; { MIPS                            }
  IMAGE_FILE_MACHINE_AXP64         =  IMAGE_FILE_MACHINE_ALPHA64;

  IMAGE_FILE_MACHINE_TRICORE       =  $520; { Infineon                        }
  IMAGE_FILE_MACHINE_CEF           =  $CEF;
  IMAGE_FILE_MACHINE_EBC           =  $EBC; { EFI Byte Code                   }

  IMAGE_FILE_MACHINE_AMD64         = $8664; { AMD64 (K8)                      }
  IMAGE_FILE_MACHINE_M32R          = $9041; { M32R little-endian              }
  IMAGE_FILE_MACHINE_ARM64         = $AA64; { ARM64 Little-Endian             }
  IMAGE_FILE_MACHINE_CEE           = $C0EE;


const
  { characteristic flags                                                      }

  IMAGE_FILE_RELOCS_STRIPPED         =    $1;
  IMAGE_FILE_EXECUTABLE_IMAGE        =    $2;
  IMAGE_FILE_LINE_NUMS_STRIPPED      =    $4;
  IMAGE_FILE_LOCAL_SYMS_STRIPPED     =    $8;

  IMAGE_FILE_AGGRESIVE_WS_TRIM       =   $10;
  IMAGE_FILE_LARGE_ADDRESS_AWARE     =   $20; { app can handle > 2gb addresses}
  IMAGE_FILE_BYTES_REVERSED_LO       =   $80;

  IMAGE_FILE_32BIT_MACHINE           =  $100;
  IMAGE_FILE_DEBUG_STRIPPED          =  $200;
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP =  $400; { image is on removable media   }
  IMAGE_FILE_NET_RUN_FROM_SWAP       =  $800; { image is on network           }

  IMAGE_FILE_SYSTEM                  = $1000;
  IMAGE_FILE_DLL                     = $2000;
  IMAGE_FILE_UP_SYSTEM_ONLY          = $4000;
  IMAGE_FILE_BYTES_REVERSED_HI       = $8000;


type
  { _IMAGE_FILE_HEADER                                                        }

  PIMAGE_FILE_HEADER = ^TIMAGE_FILE_HEADER;
  TIMAGE_FILE_HEADER = packed record
    Machine              :  word;
    NumberOfSections     :  word;
    TimeDateStamp        : DWORD;
    PointerToSymbolTable : DWORD;
    NumberOfSymbols      : DWORD;
    SizeOfOptionalHeader :  word;
    Characteristics      :  word;
  end;

const
  IMAGE_SIZEOF_FILE_HEADER      = 20;


{ --------------------------------------------------------------------------- }
{ DATA DIRECTORY related types and constants                                  }

const
  { directory indexes                                                         }

  IMAGE_DIRECTORY_ENTRY_EXPORT                   =     0;
  IMAGE_DIRECTORY_ENTRY_IMPORT                   =     1;
  IMAGE_DIRECTORY_ENTRY_RESOURCE                 =     2;
  IMAGE_DIRECTORY_ENTRY_EXCEPTION                =     3;
  IMAGE_DIRECTORY_ENTRY_SECURITY                 =     4;
  IMAGE_DIRECTORY_ENTRY_BASERELOC                =     5;
  IMAGE_DIRECTORY_ENTRY_DEBUG                    =     6;
  IMAGE_DIRECTORY_ENTRY_ARCHITECTURE             =     7;
  IMAGE_DIRECTORY_ENTRY_GLOBALPTR                =     8;
  IMAGE_DIRECTORY_ENTRY_TLS                      =     9;
  IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG              =    10;
  IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT             =    11;
  IMAGE_DIRECTORY_ENTRY_IAT                      =    12;
  IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT             =    13;
  IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR           =    14;

  IMAGE_DIRECTORY_ENTRY_COPYRIGHT      = IMAGE_DIRECTORY_ENTRY_ARCHITECTURE;

const
  IMAGE_NUMBEROF_DIRECTORY_ENTRIES = 16;

type
  TDATA_DIRECTORY_RANGE = 0 .. IMAGE_NUMBEROF_DIRECTORY_ENTRIES - 1;

type
  { _IMAGE_DATA_DIRECTORY                                                     }

  PIMAGE_DATA_DIRECTORY = ^TIMAGE_DATA_DIRECTORY;
  TIMAGE_DATA_DIRECTORY = record
    VirtualAddress          : DWORD;
    Size                    : DWORD;
  end;


{ --------------------------------------------------------------------------- }
{ OPTIONAL HEADER related types and constants                                 }

const
  IMAGE_NT_OPTIONAL_HDR32_MAGIC = $10b;
  IMAGE_NT_OPTIONAL_HDR64_MAGIC = $20b;
  IMAGE_ROM_OPTIONAL_HDR_MAGIC  = $107;

type
  PIMAGE_OPTIONAL_HEADER = ^TIMAGE_OPTIONAL_HEADER;
  TIMAGE_OPTIONAL_HEADER = packed record

    // common fields.

    Magic                       :  word;
    MajorLinkerVersion          :  byte;
    MinorLinkerVersion          :  byte;
    SizeOfCode                  : DWORD;
    SizeOfInitializedData       : DWORD;
    SizeOfUninitializedData     : DWORD;
    AddressOfEntryPoint         : DWORD;
    BaseOfCode                  : DWORD;

    { remainder of fields depend on the module's bitness                      }
  end;


type
  { _IMAGE_OPTIONAL_HEADER  _IMAGE_OPTIONAL_HEADER32                          }

  PIMAGE_OPTIONAL_HEADER32 = ^TIMAGE_OPTIONAL_HEADER32;
  TIMAGE_OPTIONAL_HEADER32 = packed record

    { common fields                                                           }

    Magic                       :  word;
    MajorLinkerVersion          :  byte;
    MinorLinkerVersion          :  byte;
    SizeOfCode                  : DWORD;
    SizeOfInitializedData       : DWORD;
    SizeOfUninitializedData     : DWORD;
    AddressOfEntryPoint         : DWORD;
    BaseOfCode                  : DWORD;

    BaseOfData                  : DWORD;  { not present in 64bit              }

    ImageBase                   : DWORD;
    SectionAlignment            : DWORD;
    FileAlignment               : DWORD;
    MajorOperatingSystemVersion :  word;
    MinorOperatingSystemVersion :  word;
    MajorImageVersion           :  word;
    MinorImageVersion           :  word;
    MajorSubsystemVersion       :  word;
    MinorSubsystemVersion       :  word;
    Win32VersionValue           : DWORD;
    SizeOfImage                 : DWORD;
    SizeOfHeaders               : DWORD;
    CheckSum                    : DWORD;
    Subsystem                   :  word;
    DllCharacteristics          :  word;

    SizeOfStackReserve          : DWORD;  { different size in 64bit           }
    SizeOfStackCommit           : DWORD;
    SizeOfHeapReserve           : DWORD;
    SizeOfHeapCommit            : DWORD;

    LoaderFlags                 : DWORD;
    NumberOfRvaAndSizes         : DWORD;
    DataDirectory               : array [TDATA_DIRECTORY_RANGE]
                                     of  TIMAGE_DATA_DIRECTORY;
  end;


{ _IMAGE_ROM_OPTIONAL_HEADER                             purposely left out   }


{$ifdef FPC}
  { no qword in Delphi 2                                                      }

  type
    { _IMAGE_OPTIONAL_HEADER  _IMAGE_OPTIONAL_HEADER64                        }

    PIMAGE_OPTIONAL_HEADER64 = ^TIMAGE_OPTIONAL_HEADER64;
    TIMAGE_OPTIONAL_HEADER64 = packed record
      Magic                       :  word;
      MajorLinkerVersion          :  byte;
      MinorLinkerVersion          :  byte;
      SizeOfCode                  : DWORD;
      SizeOfInitializedData       : DWORD;
      SizeOfUninitializedData     : DWORD;
      AddressOfEntryPoint         : DWORD;
      BaseOfCode                  : DWORD;
                                            { no BaseOfData field             }
      ImageBase                   : qword;
      SectionAlignment            : DWORD;
      FileAlignment               : DWORD;
      MajorOperatingSystemVersion :  word;
      MinorOperatingSystemVersion :  word;
      MajorImageVersion           :  word;
      MinorImageVersion           :  word;
      MajorSubsystemVersion       :  word;
      MinorSubsystemVersion       :  word;
      Win32VersionValue           : DWORD;
      SizeOfImage                 : DWORD;
      SizeOfHeaders               : DWORD;
      CheckSum                    : DWORD;
      Subsystem                   :  word;
      DllCharacteristics          :  word;
      SizeOfStackReserve          : qword;  { different size in 32bit         }
      SizeOfStackCommit           : qword;
      SizeOfHeapReserve           : qword;
      SizeOfHeapCommit            : qword;

      LoaderFlags                 : DWORD;
      NumberOfRvaAndSizes         : DWORD;
      DataDirectory               : array [TDATA_DIRECTORY_RANGE]
                                       of  TIMAGE_DATA_DIRECTORY;
    end;
{$endif}



{ --------------------------------------------------------------------------- }
{ NT Header related types and constants                                       }

const
  IMAGE_NT_SIGNATURE = DWORD($4550);          { PE00                          }

{$ifdef FPC}
  { Delphi 2 cannot handle the current definition of TIMAGE_OPTIONAL_HEADER64 }

  type
    PIMAGE_NT_HEADERS64 = ^TIMAGE_NT_HEADERS64;
    TIMAGE_NT_HEADERS64 = packed record
      Signature             : DWORD;
      FileHeader            : TIMAGE_FILE_HEADER;
      OptionalHeader        : TIMAGE_OPTIONAL_HEADER64;
    end;
{$endif}

type
  PIMAGE_NT_HEADERS32 = ^TIMAGE_NT_HEADERS32;
  TIMAGE_NT_HEADERS32 = packed record
    Signature             : DWORD;
    FileHeader            : TIMAGE_FILE_HEADER;
    OptionalHeader        : TIMAGE_OPTIONAL_HEADER32;
  end;

type
  { this type is to force the typecasting to either the 32 or 64 bit "version"}
  { of the pointer.                                                           }

  PIMAGE_NT_HEADERS  = ^TIMAGE_NT_HEADERS;
  PPIMAGE_NT_HEADERS = ^PIMAGE_NT_HEADERS;
  TIMAGE_NT_HEADERS  = record end;       { no accessible fields               }



{ --------------------------------------------------------------------------- }
{ IMAGE SECTION HEADER related types and constants                            }


  { IMAGE_FIRST_SECTION to define in inlines.inc                              }


const
  { subsystem values                                                          }

  IMAGE_SUBSYSTEM_UNKNOWN                        =     0;
  IMAGE_SUBSYSTEM_NATIVE                         =     1;
  IMAGE_SUBSYSTEM_WINDOWS_GUI                    =     2;
  IMAGE_SUBSYSTEM_WINDOWS_CUI                    =     3;
  IMAGE_SUBSYSTEM_OS2_CUI                        =     5;
  IMAGE_SUBSYSTEM_POSIX_CUI                      =     7;
  IMAGE_SUBSYSTEM_NATIVE_WINDOWS                 =     8;
  IMAGE_SUBSYSTEM_WINDOWS_CE_GUI                 =     9;
  IMAGE_SUBSYSTEM_EFI_APPLICATION                =    10;
  IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER        =    11;
  IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER             =    12;
  IMAGE_SUBSYSTEM_EFI_ROM                        =    13;
  IMAGE_SUBSYSTEM_XBOX                           =    14;
  IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION       =    16;
  IMAGE_SUBSYSTEM_XBOX_CODE_CATALOG              =    17;


const
  { dll characteristics values                                                }

  IMAGE_LIBRARY_PROCESS_INIT                     =    $1;  { reserved         }
  IMAGE_LIBRARY_PROCESS_TERM                     =    $2;  { reserved         }
  IMAGE_LIBRARY_THREAD_INIT                      =    $4;  { reserved         }
  IMAGE_LIBRARY_THREAD_TERM                      =    $8;  { reserved         }

  IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA       =   $20;
  IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE          =   $40;
  IMAGE_DLLCHARACTERISTICS_FORCE_INTEGRITY       =   $80;

  IMAGE_DLLCHARACTERISTICS_NX_COMPAT             =  $100;
  IMAGE_DLLCHARACTERISTICS_NO_ISOLATION          =  $200;
  IMAGE_DLLCHARACTERISTICS_NO_SEH                =  $400;
  IMAGE_DLLCHARACTERISTICS_NO_BIND               =  $800;

  IMAGE_DLLCHARACTERISTICS_APPCONTAINER          = $1000;
  IMAGE_DLLCHARACTERISTICS_WDM_DRIVER            = $2000;
  IMAGE_DLLCHARACTERISTICS_GUARD_CF              = $4000;
  IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE = $8000;



const
  { section characteristics                                                   }

  IMAGE_SCN_TYPE_REG               =        $0;  { reserved                   }
  IMAGE_SCN_TYPE_DSECT             =        $1;  { reserved                   }
  IMAGE_SCN_TYPE_NOLOAD            =        $2;  { reserved                   }
  IMAGE_SCN_TYPE_GROUP             =        $4;  { reserved                   }
  IMAGE_SCN_TYPE_NO_PAD            =        $8;  { reserved                   }

  IMAGE_SCN_TYPE_COPY              =       $10;  { reserved                   }

  IMAGE_SCN_CNT_CODE               =       $20;  { Section contains code      }

  IMAGE_SCN_CNT_INITIALIZED_DATA   =       $40;  { Section contains           }
                                                 { initialized data           }

  IMAGE_SCN_CNT_UNINITIALIZED_DATA =       $80;  { Section contains           }
                                                 { uninitialized data         }

  IMAGE_SCN_LNK_OTHER              =      $100;  { Reserved                   }
  IMAGE_SCN_LNK_INFO               =      $200;  { Section contains comments  }
                                                 { or some other type of      }
                                                 { information                }

  IMAGE_SCN_TYPE_OVER              =      $400;  { Reserved                   }

  IMAGE_SCN_LNK_REMOVE             =      $800;  { Section contents will not  }
                                                 { become part of image       }


  IMAGE_SCN_LNK_COMDAT             =     $1000;  { Section contents comdat    }
  IMAGE_SCN_UNKNOWN                =     $2000;  { Reserved                   }
  IMAGE_SCN_MEM_PROTECTED          =     $4000;  { obsolete                   }

  IMAGE_SCN_NO_DEFER_SPEC_EXC      =     $4000;  { Reset speculative          }
                                                 { exceptions handling bits   }
                                                 { in the TLB entries for     }
                                                 { this section               }

  IMAGE_SCN_GPREL                  =     $8000;  { Section content can be     }
                                                 { accessed relative to GP    }

  IMAGE_SCN_MEM_FARDATA            =     $8000;

  IMAGE_SCN_MEM_SYSHEAP            =    $10000;  { obsolete                   }

  IMAGE_SCN_MEM_PURGEABLE          =    $20000;
  IMAGE_SCN_MEM_16BIT              =    $20000;

  IMAGE_SCN_MEM_LOCKED             =    $40000;
  IMAGE_SCN_MEM_PRELOAD            =    $80000;

  IMAGE_SCN_ALIGN_1BYTES           =   $100000;  {                            }
  IMAGE_SCN_ALIGN_2BYTES           =   $200000;  {                            }
  IMAGE_SCN_ALIGN_4BYTES           =   $300000;  {                            }
  IMAGE_SCN_ALIGN_8BYTES           =   $400000;  {                            }

  IMAGE_SCN_ALIGN_16BYTES          =   $500000;  { Default alignment if no    }
                                                 { others are specified       }
  IMAGE_SCN_ALIGN_32BYTES          =   $600000;  {                            }
  IMAGE_SCN_ALIGN_64BYTES          =   $700000;  {                            }
  IMAGE_SCN_ALIGN_128BYTES         =   $800000;  {                            }

  IMAGE_SCN_ALIGN_256BYTES         =   $900000;  {                            }
  IMAGE_SCN_ALIGN_512BYTES         =   $A00000;  {                            }

  IMAGE_SCN_ALIGN_1024BYTES        =   $B00000;  {                            }
  IMAGE_SCN_ALIGN_2048BYTES        =   $C00000;  {                            }
  IMAGE_SCN_ALIGN_4096BYTES        =   $D00000;  {                            }
  IMAGE_SCN_ALIGN_8192BYTES        =   $E00000;  {                            }

  IMAGE_SCN_ALIGN_MASK             =   $F00000;

  IMAGE_SCN_LNK_NRELOC_OVFL        =  $1000000;  { Section contains extended  }
                                                 { relocations                }

  IMAGE_SCN_MEM_DISCARDABLE        =  $2000000;  { Section can be discarded   }
  IMAGE_SCN_MEM_NOT_CACHED         =  $4000000;  { Section is not cachable    }
  IMAGE_SCN_MEM_NOT_PAGED          =  $8000000;  { Section is not pageable    }

  IMAGE_SCN_MEM_SHARED             = $10000000;  { Section is shareable       }
  IMAGE_SCN_MEM_EXECUTE            = $20000000;  { Section is executable      }
  IMAGE_SCN_MEM_READ               = $40000000;  { Section is readable        }
  IMAGE_SCN_MEM_WRITE              = $80000000;  { Section is writeable       }


const
  { tls characteristics flags                                                 }

  IMAGE_SCN_SCALE_INDEX            = $1;         { Tls index is scaled        }


{ non COFF object file headers                                                }

{ ANON_OBJECT_HEADER                                     purposely left out   }
{ ANON_OBJECT_HEADER_V2                                  purposely left out   }
{ ANON_OBJECT_HEADER_BIGOBJ                              purposely left out   }


const
  IMAGE_SIZEOF_SHORT_NAME   = 8;
  IMAGE_SIZEOF_SECTION_NAME = IMAGE_SIZEOF_SHORT_NAME;

type
  TSECTION_NAME_RANGE       = 0 .. IMAGE_SIZEOF_SHORT_NAME - 1;

type
  TSECTION_PHYSADDR_VIRTSIZE_UNION = packed record
    case integer of
      0 : (PhysicalAddress : DWORD);
      1 : (VirtualSize     : DWORD);
  end;

type
  { _IMAGE_SECTION_HEADER                                                     }

  PIMAGE_SECTION_HEADER  = ^TIMAGE_SECTION_HEADER;
  PPIMAGE_SECTION_HEADER = ^PIMAGE_SECTION_HEADER;

  TIMAGE_SECTION_HEADER  = packed record
    Name                     : array[TSECTION_NAME_RANGE] of char;
    Misc                     : TSECTION_PHYSADDR_VIRTSIZE_UNION;
    VirtualAddress           : DWORD;
    SizeOfRawData            : DWORD;
    PointerToRawData         : DWORD;
    PointerToRelocations     : DWORD;
    PointerToLinenumbers     : DWORD;
    NumberOfRelocations      :  word;
    NumberOfLinenumbers      :  word;
    Characteristics          : DWORD;
  end;


const
  IMAGE_SIZEOF_SECTION_HEADER  = 40; { sizeof should state as much            }


{ --------------------------------------------------------------------------- }
{ IMAGE RESOURCE DIRECTORY related types and constants                        }

type
  { _IMAGE_RESOURCE_DIRECTORY                                                 }

  { Resource directory consists of two counts, following by a variable length }
  { array of directory entries.  The first count is the number of entries at  }
  { beginning of the array that have actual names associated with each entry. }
  { The entries are in ascending order, case insensitive strings.  The second }
  { count is the number of entries that immediately follow the named entries. }
  { This second count identifies the number of entries that have 16-bit       }
  { integer Ids as their name.  These entries are also sorted in ascending    }
  { order.                                                                    }
  {                                                                           }
  { This structure allows fast lookup by either name or number, but for any   }
  { given resource entry only one form of lookup is supported, not both.      }
  { This is consistant with the syntax of the .RC file and the .RES file.     }

  PIMAGE_RESOURCE_DIRECTORY  = ^TIMAGE_RESOURCE_DIRECTORY;
  PPIMAGE_RESOURCE_DIRECTORY = ^PIMAGE_RESOURCE_DIRECTORY;

  TIMAGE_RESOURCE_DIRECTORY  = packed record
    Characteristics      : DWORD;
    TimeDateStamp        : DWORD;
    MajorVersion         : word;
    MinorVersion         : word;
    NumberOfNamedEntries : word;
    NumberOfIdEntries    : word;

    { IMAGE_RESOURCE_DIRECTORY_ENTRY DirectoryEntries[];                      }
  end;


const
  IMAGE_RESOURCE_NAME_IS_STRING    = DWORD($80000000);
  IMAGE_RESOURCE_NAME_OFFSET       = DWORD($7FFFFFFF);
  IMAGE_RESOURCE_NAME_ID           = DWORD($0000FFFF);

  IMAGE_RESOURCE_DATA_IS_DIRECTORY = DWORD($80000000);
  IMAGE_RESOURCE_DATA_OFFSET       = DWORD($7FFFFFFF);

type
  { _IMAGE_RESOURCE_DIRECTORY_ENTRY definition differs from winnt.h           }

  { the fields in this data structure are encoded as follows:                 }
  {                                                                           }
  { Name: if the high bit is set then the low 31 bits of the Name are an      }
  {       offset relative to the starting offset of the resource directory to }
  {       the name string which is an IMAGE_RESOURCE_DIRECTORY_STRING.        }
  {                                                                           }
  {       if the high bit is not set then the low 16 bits of the name are an  }
  {       integer id for the entry.                                           }
  {                                                                           }
  { OffsetToData: if the high bit is set then the low 31 bits are an offset   }
  {               relative to the start of the resource directory to a        }
  {               subdirectory.                                               }
  {                                                                           }
  {               if the high bit is clear then the OffsetToData is an offset }
  {               relative to the start of the resource directory to a        }
  {               resource data entry.                                        }

  PIMAGE_RESOURCE_DIRECTORY_ENTRY = ^TIMAGE_RESOURCE_DIRECTORY_ENTRY;
  TIMAGE_RESOURCE_DIRECTORY_ENTRY = packed record
                                      Name         : DWORD;
                                      OffsetToData : DWORD;
                                    end;
  { aliases                                                                   }

  TIMAGE_RESOURCE_ENTRY           =  TIMAGE_RESOURCE_DIRECTORY_ENTRY;
  PIMAGE_RESOURCE_ENTRY           = ^TIMAGE_RESOURCE_ENTRY;


type
  { _IMAGE_RESOURCE_DIRECTORY_STRING                                          }

  { For resource directory entries that have actual string names, the Name    }
  { field of the directory entry points to an object of the following type.   }
  { All of these string objects are stored together after the last resource   }
  { directory entry and before the first resource data object.  This minimizes}
  { the impact of these variable length objects on the alignment of the fixed }
  { size directory entry objects.                                             }

  PIMAGE_RESOURCE_DIRECTORY_STRING = ^TIMAGE_RESOURCE_DIRECTORY_STRING;
  TIMAGE_RESOURCE_DIRECTORY_STRING = packed record
    Length     : word;
    NameString : array [0..0] of char;
  end;

  TIMAGE_RESOURCE_STRING =  TIMAGE_RESOURCE_DIRECTORY_STRING;
  PIMAGE_RESOURCE_STRING = ^TIMAGE_RESOURCE_STRING;


type
  PIMAGE_RESOURCE_DIRECTORY_STRING_U = ^TIMAGE_RESOURCE_DIRECTORY_STRING_U;
  TIMAGE_RESOURCE_DIRECTORY_STRING_U = packed record
    Length     : word;
    NameString : array [0..0] of widechar;
  end;

  { aliases                                                                   }

  TIMAGE_RESOURCE_STRING_U     =  TIMAGE_RESOURCE_DIRECTORY_STRING_U;
  PIMAGE_RESOURCE_STRING_U     = ^TIMAGE_RESOURCE_STRING_U;


type
  { _IMAGE_RESOURCE_DATA_ENTRY                                                }

  { The resource data entry describes a leaf node in the resource directory   }
  { tree.  It contains an offset to the resource data relative to the         }
  { beginning of the top level resource directory, a size field that gives    }
  { the length in bytes of the data, a CodePage that should be used when      }
  { decoding code point values within the resource data.  Typically for new   }
  { applications the code page would be the unicode code page.                }

  PIMAGE_RESOURCE_DATA_ENTRY  = ^TIMAGE_RESOURCE_DATA_ENTRY;
  PPIMAGE_RESOURCE_DATA_ENTRY = ^PIMAGE_RESOURCE_DATA_ENTRY;

  TIMAGE_RESOURCE_DATA_ENTRY  = record
    OffsetToData  : DWORD;
    Size          : DWORD;
    CodePage      : DWORD;
    Reserved      : DWORD;
  end;

  { aliases                                                                   }

  HRSRC           = PIMAGE_RESOURCE_DATA_ENTRY;        { _HRSRC               }


{ --------------------------------------------------------------------------- }
{ EXPORT DIRECTORY related types and constants                                }

type
  { _IMAGE_EXPORT_DIRECTORY                                                   }

  PIMAGE_EXPORT_DIRECTORY = ^TIMAGE_EXPORT_DIRECTORY;
  TIMAGE_EXPORT_DIRECTORY  = packed record
      Characteristics         : DWORD;
      TimeDateStamp           : DWORD;
      MajorVersion            : word;
      MinorVersion            : word;
      Name                    : DWORD;
      Base                    : DWORD;
      NumberOfFunctions       : DWORD;
      NumberOfNames           : DWORD;
      AddressOfFunctions      : DWORD;     { RVA from base of image           }
      AddressOfNames          : DWORD;     { RVA from base of image           }
      AddressOfNameOrdinals   : DWORD;     { RVA from base of image           }
    end;


{ --------------------------------------------------------------------------- }
{ IMPORT DIRECTORY/DESCRIPTOR related types and constants                     }

const
  {$ifdef FPC}
    { no qword in Delphi 2 - constant defined as high(int64) + 1 because      }
    { Delphi 2 whines about the constant being too large even though it is    }
    { none of its business.                                                   }

    { definition should be IMAGE_ORDINAL_FLAG64 = qword ($8000000000000000);  }

    IMAGE_ORDINAL_FLAG64 = qword (high(int64) + 1);
  {$endif}

  IMAGE_ORDINAL_FLAG32   = DWORD($80000000);


type
  { _IMAGE_IMPORT_BY_NAME                                                     }

  PIMAGE_IMPORT_BY_NAME = ^TIMAGE_IMPORT_BY_NAME;
  TIMAGE_IMPORT_BY_NAME =  packed record
    Hint                     : word;
    Name                     : array[0..0] of char;
  end;

{$ifdef FPC}
  { no qword in Delphi 2                                                      }

  type
    { _IMAGE_THUNK_DATA64                                                     }

    PIMAGE_THUNK_DATA64 = ^TIMAGE_THUNK_DATA64;
    TIMAGE_THUNK_DATA64 =  packed record
      case integer of
        0 : (ForwarderString : qword);    { pchar                             }
        1 : (Ordinal         : qword);
        2 : (AddressOfData   : qword);    { PIMAGE_IMPORT_BY_NAME             }
        3 : (Entry           : qword);    { for generic access                }
      end;
{$endif}

type
  { _IMAGE_THUNK_DATA32                                                       }

  PIMAGE_THUNK_DATA32 = ^TIMAGE_THUNK_DATA32;
  TIMAGE_THUNK_DATA32 =  packed record
    case integer of
      0 : (ForwarderString : DWORD);    { pchar                               }
      1 : (Ordinal         : DWORD);
      2 : (AddressOfData   : DWORD);    { PIMAGE_IMPORT_BY_NAME               }
      3 : (Entry           : DWORD);    { for generic access                  }
    end;

type
  { _IMAGE_THUNK_DATA                                                         }

    { NOTE: is either an IMAGE_THUNK_DATA32 or IMAGE_THUNK_DATA64 depending   }
    {       on the target's bitness                                           }

  PIMAGE_THUNK_DATA = ^TIMAGE_THUNK_DATA;
  TIMAGE_THUNK_DATA =  packed record
    case integer of
      0 : (ForwarderString : pointer);    { pchar                             }
      1 : (Ordinal         : pointer);
      2 : (AddressOfData   : pointer);    { PIMAGE_IMPORT_BY_NAME             }
      3 : (Entry           : pointer);    { for generic access                }
    end;


type
  PIMAGE_IMPORT_DESCRIPTOR = ^TIMAGE_IMPORT_DESCRIPTOR;
  TIMAGE_IMPORT_DESCRIPTOR =  packed record
    OriginalFirstThunk : DWORD;  { also referred to as "Characteristics"      }
                                 { it points to the unchanged Hint Name       }
                                 { table                                      }

    TimeDateStamp      : DWORD;  { - 1 if IAT is bound                        }
    ForwarderChain     : DWORD;  { - 1 if no forwarders                       }
    Name               : DWORD;  { pointer to library name                    }

    FirstThunk         : DWORD;  { pointer to the Import Address Table        }
                                 { (a hint name table that is modified        }
                                 { by the loader.)  NOTE: if IAT is bound     }
                                 { it is a table of actual addresses          }
  end;



{ --------------------------------------------------------------------------- }
{ BOUND IMPORTS DIRECTORY related types and constants                         }

type
  { _IMAGE_BOUND_IMPORT_DESCRIPTOR                                            }

  { the field NumberOfModuleForwarderRefs specifies the number of             }
  { TIMAGE_BOUND_FORWARDER_REF the record may be followed by.                 }

  PIMAGE_BOUND_IMPORT_DESCRIPTOR = ^TIMAGE_BOUND_IMPORT_DESCRIPTOR;
  TIMAGE_BOUND_IMPORT_DESCRIPTOR = packed record
    TimeDateStamp                    : DWORD;
    OffsetModuleName                 : word;
    NumberOfModuleForwarderRefs      : word;

    { followed by an array of zero or more TIMAGE_BOUND_FORWARDER_REF         }
  end;

  PIMAGE_BOUND_FORWARDER_REF = ^TIMAGE_BOUND_FORWARDER_REF;
  TIMAGE_BOUND_FORWARDER_REF =  packed record
    TimeDateStamp                    : DWORD;
    OffsetModuleName                 : word;
    Reserved                         : word;
  end;


{ --------------------------------------------------------------------------- }
{ DELAY LOAD IMPORTS DIRECTORY related types and constants                    }

const
  DELAY_LOAD_FIELDS_ARE_RVAS = 1;  { low bit of Attributes                    }

type
  { _IMAGE_DELAYLOAD_DESCRIPTOR renamed IMAGE_DELAY_LOAD_IMPORT_DESCRIPTOR    }

  { the data structure below is the same as ImgDelayDescr declared in         }
  { DelayImp.h but with names that are a little bit more consistent with      }
  { names in other IMAGE_... structures.                                      }

  PIMAGE_DELAY_LOAD_IMPORT_DESCRIPTOR = ^TIMAGE_DELAY_LOAD_IMPORT_DESCRIPTOR;
  TIMAGE_DELAY_LOAD_IMPORT_DESCRIPTOR = packed record
    {  0 } Attributes               : DWORD;  { attributes                    }
    {  1 } DllName                  : DWORD;  { Rva to Dll name               }
    {  2 } ModuleHandle             : DWORD;  { Rva to Module Handle          }
    {  3 } ImportAddressTable       : DWORD;  { Rva to IAT                    }
    {  4 } HintNameTable            : DWORD;  { Rva to HNT                    }
    {  5 } BoundImportAddressTable  : DWORD;  { Rva of Original Bound IAT     }
    {  6 } UnloadImportAddressTable : DWORD;  { Rva of optional copy of       }
                                              { original IAT                  }
    {  7 } TimeDateStamp            : DWORD;  { 0 if not bound                }
  end;


type
  { _IMAGE_DELAYLOAD_DESCRIPTOR                                               }

  PIMAGE_DELAYLOAD_DESCRIPTOR = ^TIMAGE_DELAYLOAD_DESCRIPTOR;
  TIMAGE_DELAYLOAD_DESCRIPTOR = {$ifdef FPC} bitpacked {$endif} record
    Attributes                    : record
      case integer of
        1 : (
             AllAttributes            : DWORD;
            );

        {$ifdef FPC}
        2 : (
             RvaBase                  :  _1bit;  { Delay load version 2       }
             ReservedAttributes       : _31bits;
            );
        {$endif}
    end;

    DllNameRVA                    : DWORD; { RVA to the name of the target library (NULL-terminated ASCII string)  }
    ModuleHandleRVA               : DWORD; { RVA to the HMODULE caching location (PHMODULE)                        }
    ImportAddressTableRVA         : DWORD; { RVA to the start of the IAT (PIMAGE_THUNK_DATA)                       }
    ImportNameTableRVA            : DWORD; { RVA to the start of the name table (PIMAGE_THUNK_DATA::AddressOfData) }
    BoundImportAddressTableRVA    : DWORD; { RVA to an optional bound IAT                                          }
    UnloadInformationTableRVA     : DWORD; { RVA to an optional unload info table                                  }
    TimeDateStamp                 : DWORD; { 0 if not bound, Otherwise, date/time of the target DLL                }
  end;

  { NOTE: cannot define PCIMAGE_DELAYLOAD_DESCRIPTOR in Pascal                }


type
  { _DELAYLOAD_PROC_DESCRIPTOR                                                }

  PDELAYLOAD_PROC_DESCRIPTOR = ^TDELAYLOAD_PROC_DESCRIPTOR;
  TDELAYLOAD_PROC_DESCRIPTOR = record
    ImportDescribedByName        : DWORD;

    Description                  : record
      case integer of
        1 : (
             Name                    : pchar;
            );

        2 : (
             Ordinal                 : DWORD;
            );
    end;
  end;


type
  { _DELAYLOAD_INFO                                                           }

  PDELAYLOAD_INFO = ^TDELAYLOAD_INFO;
  TDELAYLOAD_INFO = record
    Size                  : DWORD;
    DelayloadDescriptor   : PIMAGE_DELAYLOAD_DESCRIPTOR;
    ThunkAddress          : PIMAGE_THUNK_DATA;         { layout is bitness dependent }
    TargetDllName         : pchar;
    TargetApiDescriptor   : TDELAYLOAD_PROC_DESCRIPTOR;
    TargetModuleBase      : pointer;
    Unused                : pointer;
    LastError             : DWORD;
  end;


type
  { _DELAYLOAD_FAILURE_DLL_CALLBACK                                           }

  PDELAYLOAD_FAILURE_DLL_CALLBACK
            = procedure
                       (
                        { _in_ } InNotificationReason : DWORD;
                        { _in_ } InDelayloadInfo      : PDELAYLOAD_INFO
                       );
                       stdcall;





type
  // --------------------------------------------------------------------------
  // types for bitpacked structures found in various places such as in the
  // exception table, relocation entries and TLS characteristics among others.

  T1BITS     = 0 ..         1;
  T2BITS     = 0 ..         3;
  T3BITS     = 0 ..         7;
  T4BITS     = 0 ..        $F;
  T5BITS     = 0 ..       $1F;
  T6BITS     = 0 ..       $3F;
  T7BITS     = 0 ..       $7F;
  T8BITS     = 0 ..       $FF;           { byte                               }
  T9BITS     = 0 ..      $1FF;

  T10BITS    = 0 ..      $3FF;
  T11BITS    = 0 ..      $7FF;
  T12BITS    = 0 ..      $FFF;
  T13BITS    = 0 ..     $1FFF;
  T14BITS    = 0 ..     $3FFF;
  T15BITS    = 0 ..     $7FFF;
  T16BITS    = 0 ..     $FFFF;            { word                              }
  T17BITS    = 0 ..    $1FFFF;
  T18BITS    = 0 ..    $3FFFF;
  T19BITS    = 0 ..    $7FFFF;
  T20BITS    = 0 ..    $FFFFF;
  T21BITS    = 0 ..   $1FFFFF;
  T22BITS    = 0 ..   $3FFFFF;
  T23BITS    = 0 ..   $7FFFFF;
  T24BITS    = 0 ..   $FFFFFF;
  T25BITS    = 0 ..  $1FFFFFF;
  T26BITS    = 0 ..  $3FFFFFF;
  T27BITS    = 0 ..  $7FFFFFF;
  T28BITS    = 0 ..  $FFFFFFF;
  T29BITS    = 0 .. $1FFFFFFF;

  T30BITS    = 0 .. $3FFFFFFF;
  T31BITS    = 0 .. $7FFFFFFF;



// -----------------------------------------------------------------------------
// COFF IMAGE SYMBOL related types and contants

// see:
//
// http://www.delorie.com/djgpp/doc/coff/symtab.html
//
// for detailed information about the meaning of the fields in IMAGE_SYMBOL as
// well as winnt.h


const
  // these value can be found in the SymSectionNumber to indicate the meaning
  // of the SymValue field

  IMAGE_SYM_UNDEFINED      =        0;       // symbol is undefined or common
  IMAGE_SYM_ABSOLUTE       = word(-1);       // symbol is an absolute value
  IMAGE_SYM_DEBUG          = word(-2);       // symbol is a special debug item
  IMAGE_SYM_SECTION_MAX    = word($FEFF);    // values 0xFF00-0xFFFF are special

  IMAGE_SYM_SECTION_MAX_EX = high(int16);


const
  // Symbol Types - fundamental types

  IMAGE_SYM_TYPE_NULL       = $0000;         // no type
  IMAGE_SYM_TYPE_VOID       = $0001;         //
  IMAGE_SYM_TYPE_CHAR       = $0002;         // type character
  IMAGE_SYM_TYPE_SHORT      = $0003;         // type short integer
  IMAGE_SYM_TYPE_INT        = $0004;         //
  IMAGE_SYM_TYPE_LONG       = $0005;         //
  IMAGE_SYM_TYPE_FLOAT      = $0006;         //
  IMAGE_SYM_TYPE_DOUBLE     = $0007;         //
  IMAGE_SYM_TYPE_STRUCT     = $0008;         //
  IMAGE_SYM_TYPE_UNION      = $0009;         //
  IMAGE_SYM_TYPE_ENUM       = $000A;         // enumeration
  IMAGE_SYM_TYPE_MOE        = $000B;         // member of enumeration
  IMAGE_SYM_TYPE_BYTE       = $000C;         //
  IMAGE_SYM_TYPE_WORD       = $000D;         //
  IMAGE_SYM_TYPE_UINT       = $000E;         //
  IMAGE_SYM_TYPE_DWORD      = $000F;         //
  IMAGE_SYM_TYPE_PCODE      = $8000;         //

   // Symbol types - derived types

  IMAGE_SYM_DTYPE_NULL      =     0;         // no derived type
  IMAGE_SYM_DTYPE_POINTER   =     1;         // pointer
  IMAGE_SYM_DTYPE_FUNCTION  =     2;         // function
  IMAGE_SYM_DTYPE_ARRAY     =     3;         // array


// Type entry
//
// The type field in the symbol table entry contains information about the basic
// and derived type for the symbol. This information is generated by the C
// compilation system only if the -g option is used. Each symbol has exactly one
// basic or fundamental type but can have more than one derived type. The format
// of the 16-bit type entry is:
//
// dx are two bits each, type is one nibble (4 bits)
//
// d6      d5      d4      d3      d2      d1      type
//
//
// Bits 0 through 3, called type, indicate one of the fundamental types given in
// the Fundamental types table below:
//
// Fundamental types
//
// Mnemonic                      Value                    Type
//
// T_NULL                            0       type not assigned
//      1            function argument                   T_ARG
//             (used only by compiler)
//
//      2                    character                  T_CHAR
//      3                short integer                 T_SHORT
//      4                      integer                   T_INT
//      5                 long integer                  T_LONG
//      6               floating point                 T_FLOAT
//      7                  double word                T_DOUBLE
//      8                    structure                T_STRUCT
//      9                        union                 T_UNION
//     10                  enumeration                  T_ENUM
//     11        member of enumeration                   T_MOE
//     12           unsigned character                 T_UCHAR
//     13               unsigned short                T_USHORT
//     14             unsigned integer                  T_UINT
//     15                unsigned long                 T_ULONG
//
// Bits 4 through 15 are arranged as six 2-bit fields marked d1 through d6.
// These d fields represent levels of the derived types given in given in the
// Derived types table below:
//
// Derived types
//
// Mnemonic        Value                  Type
//
// DT_NON              0       no derived type
// DT_PTR              1               pointer
// DT_FCN              2              function
// DT_ARY              3                 array
//
// The following examples demonstrate the interpretation of the symbol table
// entry representing type:
//
//    char *func();
//
// Here func is the name of a function that returns a pointer to a character.
// The fundamental type of func is 2 (character), the d1 field is 2 (function),
// and the d2 field is 1 (pointer).
//
// Therefore, the type word in the symbol table for func contains the
// hexadecimal number 0x62, which is interpreted to mean a function that
// returns a pointer to a character.
//
//
//    short *tabptr[10][25][3];
//
// Here tabptr is a three-dimensional array of pointers to short integers. The
// fundamental type of tabptr is 3 (short integer); the d1, d2, and d3 fields
// each contains a 3 (array), and the d4 field is 1 (pointer).
//
// Therefore, the type entry in the symbol table contains the hexadecimal
// number 0x7f3 indicating a three-dimensional array of pointers to short
// integers.


const
   // Symbol storage classes

  IMAGE_SYM_CLASS_END_OF_FUNCTION  = byte(-1);
  IMAGE_SYM_CLASS_NULL             =  $0;
  IMAGE_SYM_CLASS_AUTOMATIC        =  $1;
  IMAGE_SYM_CLASS_EXTERNAL         =  $2;
  IMAGE_SYM_CLASS_STATIC           =  $3;
  IMAGE_SYM_CLASS_REGISTER         =  $4;
  IMAGE_SYM_CLASS_EXTERNAL_DEF     =  $5;
  IMAGE_SYM_CLASS_LABEL            =  $6;
  IMAGE_SYM_CLASS_UNDEFINED_LABEL  =  $7;
  IMAGE_SYM_CLASS_MEMBER_OF_STRUCT =  $8;
  IMAGE_SYM_CLASS_ARGUMENT         =  $9;
  IMAGE_SYM_CLASS_STRUCT_TAG       =  $A;
  IMAGE_SYM_CLASS_MEMBER_OF_UNION  =  $B;
  IMAGE_SYM_CLASS_UNION_TAG        =  $C;
  IMAGE_SYM_CLASS_TYPE_DEFINITION  =  $D;
  IMAGE_SYM_CLASS_UNDEFINED_STATIC =  $E;
  IMAGE_SYM_CLASS_ENUM_TAG         =  $F;
  IMAGE_SYM_CLASS_MEMBER_OF_ENUM   = $10;
  IMAGE_SYM_CLASS_REGISTER_PARAM   = $11;
  IMAGE_SYM_CLASS_BIT_FIELD        = $12;

  IMAGE_SYM_CLASS_FAR_EXTERNAL     = $44;

  IMAGE_SYM_CLASS_BLOCK            = $64;
  IMAGE_SYM_CLASS_FUNCTION         = $65;
  IMAGE_SYM_CLASS_END_OF_STRUCT    = $66;
  IMAGE_SYM_CLASS_FILE             = $67;

  IMAGE_SYM_CLASS_SECTION          = $68;
  IMAGE_SYM_CLASS_WEAK_EXTERNAL    = $69;

  IMAGE_SYM_CLASS_CLR_TOKEN        = $6B;


type
  // if the symbol name is inline and it is exactly 8 characters long then it
  // is not null terminated.  This buffer type provides a large enough buffer
  // where the symbol name can be copied and be null terminated.  Note that
  // this buffer may also be used to hold a symbol name that is present in the
  // string table, for this reason it cannot be made to simply hold 8 characters
  // and a null terminator since most strings in the string table are longer
  // than that.

  TSYM_NAME_BUFFER  = array[0..1023] of char;

  TSYMBOL_NAME_INFO = packed record
    case integer of
      0 : (SymName         : packed array[0..7] of char);
      1 : (
           SymNameInline   : boolean32;  // use SymNameOffset if false
           SymNameOffset   : DWORD;      // offset to name into string table
          );
  end;


type
  // WARNING: this definition depends on how FPC does bitpacking and also how
  //          it accesses bitpacked fields (this definition is tested and known
  //          valid only for FPC v3.0.4)

  TSYM_TYPE_RANGE         = -2..5;  // the bitfields 1..6 start at index 0
  TSYM_TYPE_DERIVED_RANGE =  0..5;

  TSYM_TYPE = bitpacked record
    case integer of
    0 : (
          FundamentalType  : T4BITS;

          DerivedType1     : T2BITS;
          DerivedType2     : T2BITS;
          DerivedType3     : T2BITS;
          DerivedType4     : T2BITS;
          DerivedType5     : T2BITS;
          DerivedType6     : T2BITS;
        );

    1 : (
          // tested the array representation with value $7F3 and it _seems_ to
          // work as expected.

          DerivedType      : bitpacked array[TSYM_TYPE_RANGE] of T2BITS;
        );

    2 : (
          TypeWord         : word;
        );

  end;


type
  PIMAGE_SYMBOL = ^TIMAGE_SYMBOL;                                      // 18
  TIMAGE_SYMBOL = packed record
    SymNameInfo            : TSYMBOL_NAME_INFO;
    SymValue               : DWORD;
    SymSectionNumber       : word;       // usually the 1 based section number
                                         // but see IMAGE_SYM... constants

    SymType                : TSYM_TYPE;  // see IMAGE_SYM_TYPE...  constants
    SymStorageClass        : byte;       // see IMAGE_SYM_CLASS... constants
    SymNumberOfAuxSymbols  : byte;
  end;


type
  PSYMBOL_STRING_TABLE = ^TSYMBOL_STRING_TABLE;
  TSYMBOL_STRING_TABLE = packed record
    Size                   : DWORD;

    // the following is an array of variable length null terminated strings

    Characters             : packed array[0..0] of char;
  end;



// END of file
// ----------------------------------------------------------------------------
