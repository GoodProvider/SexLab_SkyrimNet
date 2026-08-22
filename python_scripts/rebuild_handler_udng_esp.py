# Rebuild SkyrimNet_SexLab_Handler_UDNG.esp: drop SkyrimNetUDNG.esp master / udng_groups.
# TES4 + PlayerRef alias cloned from Handler_DOM.esp (Skyrim.esm, SexLab.esm).
import shutil
import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "SkyrimNet_SexLab_Handler_DOM.esp"
DST = ROOT / "SkyrimNet_SexLab_Handler_UDNG.esp"
BAK = ROOT / "SkyrimNet_SexLab_Handler_UDNG.esp.bak"


def zstr(s: str) -> bytes:
    return s.encode("ascii") + b"\x00"


def sub(typ: bytes, payload: bytes) -> bytes:
    return typ + struct.pack("<H", len(payload)) + payload


def wstr(s: str) -> bytes:
    b = zstr(s)
    return struct.pack("<H", len(b)) + b


def main() -> None:
    dom = SRC.read_bytes()
    tes4_size = struct.unpack_from("<I", dom, 4)[0]
    tes4 = bytes(dom[: 24 + tes4_size])

    vmad_at = dom.find(b"VMAD")
    vmad_sz = struct.unpack_from("<H", dom, vmad_at + 4)[0]
    vmad_dom = dom[vmad_at + 6 : vmad_at + 6 + vmad_sz]
    # After quest script (0 props): keep fragment + alias VMAD tail.
    rest = vmad_dom[6:]  # skip ver/fmt/count
    # skip script name + flags + nprop
    nlen = struct.unpack_from("<H", rest, 0)[0]
    rest = rest[2 + nlen + 1 + 2 :]
    old_pr = b"SkyrimNet_SexLab_Handler_DOM_PR\x00"
    new_pr = b"SkyrimNet_SexLab_Handler_UDNG_PR\x00"
    if old_pr not in rest:
        raise SystemExit("DOM PR script name not found in VMAD tail")
    rest = rest.replace(old_pr, new_pr, 1)
    # length prefix before PR name is uint16 0x001f (31); UDNG PR is 32 bytes with NUL
    rest = rest.replace(struct.pack("<H", len(old_pr)) + new_pr, struct.pack("<H", len(new_pr)) + new_pr, 1)
    # replace may have left 1f 00 + new 32-byte name if replace order was wrong
    idx = rest.find(new_pr)
    if idx < 2:
        raise SystemExit("PR name missing after swap")
    rest = rest[: idx - 2] + struct.pack("<H", len(new_pr)) + rest[idx:]

    vmad = bytearray()
    vmad += struct.pack("<HHH", 5, 2, 1)
    vmad += wstr("SkyrimNet_SexLab_Handler_UDNG")
    vmad += b"\x00"
    vmad += struct.pack("<H", 0)
    vmad += rest

    data = b""
    data += sub(b"EDID", zstr("skyrimnet_sexlab_udng_handler"))
    data += sub(b"VMAD", bytes(vmad))
    data += sub(b"FULL", zstr("SkyrimNet SexLab Handler UDNG"))
    data += sub(b"DNAM", bytes.fromhex("110100ff0000000000000000"))
    data += sub(b"NEXT", b"")
    data += sub(b"ANAM", struct.pack("<I", 1))
    data += sub(b"ALST", struct.pack("<I", 0))
    data += sub(b"ALID", zstr("PlayerRef"))
    data += sub(b"FNAM", struct.pack("<I", 0))
    data += sub(b"ALFR", struct.pack("<I", 0x14))
    data += sub(b"VTCK", struct.pack("<I", 0))
    data += sub(b"ALED", b"")

    fid = 0x02000800
    qust = (
        b"QUST"
        + struct.pack("<I", len(data))
        + struct.pack("<I", 0)
        + struct.pack("<I", fid)
        + struct.pack("<I", 0)
        + struct.pack("<HH", 44, 0)
        + data
    )
    empty = (
        b"QUST"
        + struct.pack("<I", 0)
        + struct.pack("<I", 0)
        + struct.pack("<I", 0)
        + struct.pack("<I", 0)
        + struct.pack("<HH", 44, 0)
    )
    grup_content = empty + qust
    stamp = struct.unpack_from("<I", dom, 24 + tes4_size + 16)[0]
    grup = (
        b"GRUP"
        + struct.pack("<I", 24 + len(grup_content))
        + b"QUST"
        + struct.pack("<I", 0)
        + struct.pack("<I", stamp)
        + struct.pack("<I", 0)
        + grup_content
    )

    if DST.exists():
        shutil.copy2(DST, BAK)
    DST.write_bytes(tes4 + grup)
    print("wrote", DST, "bytes", DST.stat().st_size)


if __name__ == "__main__":
    main()
