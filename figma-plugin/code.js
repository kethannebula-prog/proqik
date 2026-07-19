const C = {
  primary: { r: 0.141, g: 0.322, b: 0.231 },
  sandLight: { r: 0.957, g: 0.922, b: 0.863 },
  white: { r: 1, g: 1, b: 1 },
  dark: { r: 0.043, g: 0.043, b: 0.043 },
  gray: { r: 0.533, g: 0.533, b: 0.533 },
  success: { r: 0.298, g: 0.686, b: 0.314 },
  border: { r: 0.933, g: 0.933, b: 0.933 },
  bg: { r: 0.91, g: 0.91, b: 0.91 },
  gold: { r: 0.929, g: 0.722, b: 0.231 },
};

const W = 286;
const H = 749;
const FAM = "Inter";

function solid(c) { return { type: "SOLID", color: c }; }

function makeFrame(n, w, h, fill) {
  const f = figma.createFrame();
  f.name = n; f.resize(w, h);
  if (fill) f.fills = [solid(fill)];
  f.clipsContent = true;
  return f;
}

function makeRect(n, w, h, fill, r) {
  const o = figma.createRectangle();
  o.name = n; o.resize(w, h);
  if (fill) o.fills = [solid(fill)];
  if (typeof r === "number") o.cornerRadius = r;
  if (typeof r === "object" && r !== null) {
    if (r.topLeft !== undefined) o.topLeftRadius = r.topLeft;
    if (r.topRight !== undefined) o.topRightRadius = r.topRight;
    if (r.bottomLeft !== undefined) o.bottomLeftRadius = r.bottomLeft;
    if (r.bottomRight !== undefined) o.bottomRightRadius = r.bottomRight;
  }
  return o;
}

function makeText(n, str, sz, style, color) {
  const t = figma.createText();
  t.name = n;
  t.fontName = { family: FAM, style: style };
  t.characters = str;
  t.fontSize = sz;
  if (color) t.fills = [solid(color)];
  return t;
}

async function main() {
  try {
    await figma.loadFontAsync({ family: FAM, style: "Regular" });
    await figma.loadFontAsync({ family: FAM, style: "Medium" });
    await figma.loadFontAsync({ family: FAM, style: "Semi Bold" });
    await figma.loadFontAsync({ family: FAM, style: "Bold" });

    // Screen 1 - Dashboard
    const s1 = makeFrame("1 - Dashboard", W, H, C.bg);
    s1.x = 0; s1.y = 0;

    // Status bar
    const sb1 = makeFrame("_sb", W, 36, C.primary);
    const tm1 = makeText("_tm", "9:41", 11, "Semi Bold", C.white);
    tm1.x = 16; tm1.y = 10;
    sb1.appendChild(tm1);
    s1.appendChild(sb1);

    // Header: eDollar + bell
    const hdr1 = makeFrame("_hdr", W, 44, C.primary);
    hdr1.y = 36;
    const ti1 = makeText("_ti", "eDollar", 13, "Semi Bold", C.white);
    ti1.x = 16; ti1.y = 14;
    hdr1.appendChild(ti1);
    const be1 = makeText("_be", "🔔", 14, "Regular", C.white);
    be1.x = W-32; be1.y = 14;
    hdr1.appendChild(be1);
    s1.appendChild(hdr1);

    // Green background area
    const gb = makeRect("_gb", W, 88, C.primary);
    gb.y = 80;
    s1.appendChild(gb);

    // Points Card (overlapping green bg)
    const card = makeFrame("_card", W-24, 80, C.white);
    card.x = 12; card.y = 60; card.cornerRadius = 14;
    const acc = makeRect("_acc", W-24, 4, C.primary, {topLeft:14,topRight:14,bottomLeft:0,bottomRight:0});
    card.appendChild(acc);
    // Star icon
    const st = makeText("_st", "⭐", 16, "Regular", C.dark);
    st.x = 14; st.y = 12;
    card.appendChild(st);
    // BSP Points Earned label
    const lbl = makeText("_lbl", "BSP Points Earned", 9, "Medium", C.gray);
    lbl.x = 40; lbl.y = 14;
    card.appendChild(lbl);
    // Points value
    const pts = makeText("_pts", "12,850 pts", 16, "Bold", C.primary);
    pts.x = 14; pts.y = 32;
    card.appendChild(pts);
    // Dollar equivalent
    const sub = makeText("_sub", "≈ $128.50 value", 9, "Medium", C.success);
    sub.x = 14; sub.y = 54;
    card.appendChild(sub);
    // Chevron arrow
    const ar = makeText("_ar", "›", 18, "Bold", C.gold);
    ar.x = W-24-20; ar.y = 28;
    card.appendChild(ar);
    s1.appendChild(card);

    // Redeem button
    const rbtn = makeFrame("_rbtn", 120, 36, C.white);
    rbtn.x = (W-120)/2; rbtn.y = 168; rbtn.cornerRadius = 10;
    const rl = makeText("_rl", "Redeem", 10, "Medium", C.dark);
    rl.x = 34; rl.y = 10;
    rbtn.appendChild(rl);
    s1.appendChild(rbtn);

    // Screen 2
    const s2 = makeFrame("2 - Points Detail", W, H, C.bg);
    s2.x = W+20; s2.y = 0;
    const sb2 = makeFrame("_sb", W, 36, C.primary);
    const tm2 = makeText("_tm", "9:41", 11, "Semi Bold", C.white);
    tm2.x = 16; tm2.y = 10;
    sb2.appendChild(tm2);
    s2.appendChild(sb2);
    const h2 = makeFrame("_hd", W, 44, C.primary);
    h2.y = 36;
    const b2 = makeText("_bk", "‹", 18, "Semi Bold", C.white); b2.x=12; b2.y=10; h2.appendChild(b2);
    const ti2 = makeText("_ti", "BSP Points Earned", 13, "Semi Bold", C.white); ti2.x=36; ti2.y=11; h2.appendChild(ti2);
    s2.appendChild(h2);

    const hero = makeFrame("_hero", W, 100);
    hero.y = 96;
    const bg = makeText("_bg", "12,850", 32, "Bold", C.primary); bg.x=W/2-50; bg.y=0; bg.textAlignHorizontal="CENTER"; hero.appendChild(bg);
    const un = makeText("_un", "pts", 13, "Medium", C.gray); un.x=W/2-10; un.y=38; un.textAlignHorizontal="CENTER"; hero.appendChild(un);
    const eq = makeText("_eq", "≈ $128.50", 11, "Medium", C.success); eq.x=W/2-35; eq.y=58; eq.textAlignHorizontal="CENTER"; hero.appendChild(eq);
    s2.appendChild(hero);

    const nt = makeFrame("_nt", W-24, 30, C.sandLight);
    nt.x = 12; nt.y = 206; nt.cornerRadius = 8;
    const ntt = makeText("_ntt", "Points across all wallets. 100 pts = $1.00", 8, "Medium", C.primary); ntt.x=10; ntt.y=8; nt.appendChild(ntt);
    s2.appendChild(nt);

    const rbtn2 = makeFrame("_rbtn2", W-24, 38, C.primary);
    rbtn2.x = 12; rbtn2.y = H-58; rbtn2.cornerRadius = 10;
    const rt2 = makeText("_rl2", "Redeem Points", 11, "Semi Bold", C.white); rt2.x=80; rt2.y=10; rt2.textAlignHorizontal="CENTER"; rbtn2.appendChild(rt2);
    s2.appendChild(rbtn2);

    // Screen 3
    const s3 = makeFrame("3 - Redemption Choice", W, H, C.bg);
    s3.x = (W+20)*2; s3.y = 0;
    const sb3 = makeFrame("_sb", W, 36, C.primary);
    const tm3 = makeText("_tm", "9:41", 11, "Semi Bold", C.white);
    tm3.x = 16; tm3.y = 10;
    sb3.appendChild(tm3);
    s3.appendChild(sb3);
    const h3 = makeFrame("_hd", W, 44, C.primary);
    h3.y = 36;
    const b3 = makeText("_bk", "‹", 18, "Semi Bold", C.white); b3.x=12; b3.y=10; h3.appendChild(b3);
    const ti3 = makeText("_ti", "Redeem Points", 13, "Semi Bold", C.white); ti3.x=36; ti3.y=11; h3.appendChild(ti3);
    s3.appendChild(h3);

    const bal = makeFrame("_bal", W, 60);
    bal.y = 92;
    const bl = makeText("_bl", "Available Balance", 10, "Medium", C.gray); bl.x=12; bl.y=0; bal.appendChild(bl);
    const bp = makeText("_bp", "12,850 pts", 20, "Bold", C.primary); bp.x=12; bp.y=16; bal.appendChild(bp);
    const bv = makeText("_bv", "= $128.50", 10, "Medium", C.success); bv.x=12; bv.y=40; bal.appendChild(bv);
    s3.appendChild(bal);

    const sl = makeText("_sl", "Choose redemption type", 10, "Semi Bold", C.dark); sl.x=12; sl.y=164; s3.appendChild(sl);

    const pc = makeFrame("_partial", W-24, 56, C.white);
    pc.x = 12; pc.y = 182; pc.cornerRadius = 12;
    pc.strokeWeight = 1.5; pc.strokes = [{ type: "SOLID", color: C.border }];
    const pt = makeText("_pt", "Partial Redemption", 11, "Semi Bold", C.dark); pt.x=12; pt.y=8; pc.appendChild(pt);
    const pd = makeText("_pd", "Enter a specific amount", 9, "Regular", C.gray); pd.x=12; pd.y=28; pc.appendChild(pd);
    s3.appendChild(pc);

    const fc = makeFrame("_full", W-24, 56, C.white);
    fc.x = 12; fc.y = 246; fc.cornerRadius = 12;
    fc.strokeWeight = 1.5; fc.strokes = [{ type: "SOLID", color: C.border }];
    const ft = makeText("_ft", "Full Redemption", 11, "Semi Bold", C.dark); ft.x=12; ft.y=8; fc.appendChild(ft);
    const fd = makeText("_fd", "Redeem all points - balance zeroes", 9, "Regular", C.gray); fd.x=12; fd.y=28; fc.appendChild(fd);
    s3.appendChild(fc);

    const ccl3 = makeFrame("_ccl3", 126, 38, C.white);
    ccl3.x = 12; ccl3.y = H-58; ccl3.cornerRadius = 10;
    ccl3.strokeWeight = 1.5; ccl3.strokes = [{ type: "SOLID", color: C.border }];
    const ct3 = makeText("_ct3", "Cancel", 11, "Semi Bold", C.dark); ct3.x=42; ct3.y=10; ccl3.appendChild(ct3);
    s3.appendChild(ccl3);

    const cfm3 = makeFrame("_cfm3", 126, 38, C.primary);
    cfm3.x = 148; cfm3.y = H-58; cfm3.cornerRadius = 10;
    const cf3 = makeText("_cf3", "Confirm", 11, "Semi Bold", C.white); cf3.x=38; cf3.y=10; cfm3.appendChild(cf3);
    s3.appendChild(cfm3);

    // Screen 4
    const s4 = makeFrame("4 - Wallet Selection", W, H, C.bg);
    s4.x = (W+20)*3; s4.y = 0;
    const sb4 = makeFrame("_sb", W, 36, C.primary);
    const tm4 = makeText("_tm", "9:41", 11, "Semi Bold", C.white);
    tm4.x = 16; tm4.y = 10;
    sb4.appendChild(tm4);
    s4.appendChild(sb4);
    const h4 = makeFrame("_hd", W, 44, C.primary);
    h4.y = 36;
    const b4 = makeText("_bk", "‹", 18, "Semi Bold", C.white); b4.x=12; b4.y=10; h4.appendChild(b4);
    const ti4 = makeText("_ti", "Select Wallet", 13, "Semi Bold", C.white); ti4.x=36; ti4.y=11; h4.appendChild(ti4);
    s4.appendChild(h4);

    const sll = makeText("_sll", "Choose wallet to credit", 10, "Semi Bold", C.dark); sll.x=12; sll.y=94; s4.appendChild(sll);
    const wallets = [
      ["90000000127 - Travel Wallet", "FJD 4,830.00"],
      ["90000000190 - Air Flight", "FJD 3,091.49"],
      ["90000000065 - Food Wallet", "FJD 3.00"]
    ];
    wallets.forEach((w, i) => {
      const wc = makeFrame("_w"+i, W-24, 50, C.white);
      wc.x = 12; wc.y = 116 + i*58; wc.cornerRadius = 10;
      wc.strokeWeight = 1.5;
      wc.strokes = [{ type: "SOLID", color: i===0 ? C.primary : C.border }];
      const wn = makeText("_wn", w[0], 11, "Semi Bold", C.dark); wn.x=12; wn.y=6; wc.appendChild(wn);
      const wb = makeText("_wb", w[1], 10, "Semi Bold", C.primary); wb.x=W-24-90; wb.y=14; wc.appendChild(wb);
      s4.appendChild(wc);
    });

    const nt4 = makeFrame("_nt4", W-24, 28, C.sandLight);
    nt4.x = 12; nt4.y = 116 + 3*58 + 10; nt4.cornerRadius = 8;
    const nt4t = makeText("_nt4t", "MPIN required to authorize redemption", 8, "Medium", C.primary); nt4t.x=10; nt4t.y=8; nt4.appendChild(nt4t);
    s4.appendChild(nt4);

    const ccl4 = makeFrame("_ccl4", 126, 38, C.white);
    ccl4.x = 12; ccl4.y = H-58; ccl4.cornerRadius = 10;
    ccl4.strokeWeight = 1.5; ccl4.strokes = [{ type: "SOLID", color: C.border }];
    const ct4 = makeText("_ct4", "Cancel", 11, "Semi Bold", C.dark); ct4.x=42; ct4.y=10; ccl4.appendChild(ct4);
    s4.appendChild(ccl4);

    const cfm4 = makeFrame("_cfm4", 126, 38, C.primary);
    cfm4.x = 148; cfm4.y = H-58; cfm4.cornerRadius = 10;
    const cf4 = makeText("_cf4", "Confirm", 11, "Semi Bold", C.white); cf4.x=38; cf4.y=10; cfm4.appendChild(cf4);
    s4.appendChild(cfm4);

    // Screen 5 - MPIN
    const s5 = makeFrame("5 - MPIN", W, H, C.bg);
    s5.x = (W+20)*4; s5.y = 0;
    const sb5 = makeFrame("_sb", W, 36, C.primary);
    const tm5 = makeText("_tm", "9:41", 11, "Semi Bold", C.white);
    tm5.x = 16; tm5.y = 10;
    sb5.appendChild(tm5);
    s5.appendChild(sb5);
    const h5 = makeFrame("_hd", W, 44, C.primary);
    h5.y = 36;
    const b5 = makeText("_bk", "‹", 18, "Semi Bold", C.white); b5.x=12; b5.y=10; h5.appendChild(b5);
    const ti5 = makeText("_ti", "Enter MPIN", 13, "Semi Bold", C.white); ti5.x=36; ti5.y=11; h5.appendChild(ti5);
    s5.appendChild(h5);

    const lock = makeFrame("_lock", 48, 48, C.sandLight);
    lock.x = (W-48)/2; lock.y = 136; lock.cornerRadius = 24;
    const lk = makeText("_lk", "🔒", 20, "Regular", C.primary); lk.x=14; lk.y=13; lock.appendChild(lk);
    s5.appendChild(lock);

    const mh = makeText("_mh", "Enter your MPIN", 13, "Semi Bold", C.dark); mh.x=72; mh.y=204; mh.textAlignHorizontal="CENTER"; s5.appendChild(mh);
    const ms = makeText("_ms", "Authorize redemption", 9, "Regular", C.gray); ms.x=72; ms.y=224; ms.textAlignHorizontal="CENTER"; s5.appendChild(ms);

    const dots = makeFrame("_dots", 120, 14);
    dots.x = (W-120)/2; dots.y = 252;
    for (let i=0; i<4; i++) {
      const d = makeRect("_d"+i, 12, 12, null, 6);
      d.x = i*32; d.strokes = [{ type: "SOLID", color: C.gray }]; d.strokeWeight = 1.5;
      if (i===0) d.fills = [solid(C.primary)];
      dots.appendChild(d);
    }
    s5.appendChild(dots);

    const kp = makeFrame("_kp", 186, 240);
    kp.x = (W-186)/2; kp.y = 296;
    const ks = ["1","2","3","4","5","6","7","8","9","","0","⌫"];
    ks.forEach((k, i) => {
      if (k==="") return;
      const ky = makeFrame("_k"+k, 56, 46, C.white);
      ky.x = (i%3)*63; ky.y = Math.floor(i/3)*52; ky.cornerRadius = 10;
      // ky effects removed
      const fs = k==="⌫" ? 14 : 18;
      const fw = k==="⌫" ? "Regular" : "Semi Bold";
      const kt = makeText("_kt", k, fs, fw, C.dark); kt.x=18; kt.y=10; kt.textAlignHorizontal="CENTER"; ky.appendChild(kt);
      kp.appendChild(ky);
    });
    s5.appendChild(kp);

    // Screen 6 - Success
    const s6 = makeFrame("6 - Success", W, H, C.bg);
    s6.x = (W+20)*5; s6.y = 0;
    const sb6 = makeFrame("_sb", W, 36, C.primary);
    const tm6 = makeText("_tm", "9:41", 11, "Semi Bold", C.white);
    tm6.x = 16; tm6.y = 10;
    sb6.appendChild(tm6);
    s6.appendChild(sb6);
    const h6 = makeFrame("_hd", W, 44, C.primary);
    h6.y = 36;
    const ti6 = makeText("_ti", "Success", 13, "Semi Bold", C.white); ti6.x=96; ti6.y=11; ti6.textAlignHorizontal="CENTER"; h6.appendChild(ti6);
    s6.appendChild(h6);

    const ck = makeFrame("_ck", 60, 60, { r: 0.91, g: 0.96, b: 0.914 });
    ck.x = (W-60)/2; ck.y = 216; ck.cornerRadius = 30;
    const ckt = makeText("_ckt", "✓", 28, "Bold", C.success); ckt.x=20; ckt.y=14; ck.appendChild(ckt);
    s6.appendChild(ck);

    const sh = makeText("_sh", "Redemption Successful!", 16, "Bold", C.primary); sh.x=28; sh.y=296; sh.textAlignHorizontal="CENTER"; s6.appendChild(sh);
    const ss = makeText("_ss", "Your points have been redeemed", 10, "Regular", C.gray); ss.x=44; ss.y=320; ss.textAlignHorizontal="CENTER"; s6.appendChild(ss);
    const sa = makeText("_sa", "$5.00", 20, "Bold", C.primary); sa.x=100; sa.y=348; sa.textAlignHorizontal="CENTER"; s6.appendChild(sa);
    const sw = makeText("_sw", "Credited to 90000000127 - Travel Wallet", 9, "Regular", C.gray); sw.x=36; sw.y=376; sw.textAlignHorizontal="CENTER"; s6.appendChild(sw);
    const sn = makeText("_sn", "New Balance: 12,350 pts", 10, "Medium", C.success); sn.x=56; sn.y=400; sn.textAlignHorizontal="CENTER"; s6.appendChild(sn);

    const rbtn6 = makeFrame("_rbtn6", W-24, 38, C.primary);
    rbtn6.x = 12; rbtn6.y = H-58; rbtn6.cornerRadius = 10;
    const rt6 = makeText("_rl6", "Done", 11, "Semi Bold", C.white); rt6.x=108; rt6.y=10; rt6.textAlignHorizontal="CENTER"; rbtn6.appendChild(rt6);
    s6.appendChild(rbtn6);

    figma.closePlugin("6 BSP Wallet Rewards screens generated!");
  } catch (e) {
    figma.closePlugin("Error: " + e.message);
  }
}

main();
