"""
demo_app_pro.py - Modern UI skin for demo_app.py

Put this file in the SAME folder as demo_app.py, then run:
    python -m streamlit run demo_app_pro.py

It runs your original demo_app.py untouched, then applies the new look.
To change colours, edit the values in the :root { ... } block below.
"""
import runpy
from pathlib import Path

import streamlit as st

HERE = Path(__file__).resolve().parent

# demo_app.py calls st.set_page_config itself; we only want it called once.
st.set_page_config(
    page_title="Sales Analysis System",
    page_icon="📊",
    layout="wide",
    initial_sidebar_state="expanded",
)
st.set_page_config = lambda *a, **k: None

SKIN = """
<style>
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');

/* ====== EDIT COLOURS HERE ====== */
:root {
  --brand:      #10b981;
  --brand-dark: #047857;
  --brand-deep: #064e3b;
  --accent:     #06b6d4;
  --ink:        #0b1f1a;
  --muted:      #64748b;
  --line:       rgba(15, 23, 42, .07);
  --radius:     20px;
  --shadow:     0 1px 2px rgba(15,23,42,.04), 0 8px 24px rgba(15,23,42,.06);
  --shadow-hov: 0 14px 34px rgba(16,185,129,.18);
}

html, body, [class*="css"], .stApp {
  font-family: 'Plus Jakarta Sans', 'Inter', sans-serif !important;
}

/* ---------- App background ---------- */
.stApp {
  background:
    radial-gradient(900px 500px at 100% -10%, rgba(16,185,129,.14), transparent 60%),
    radial-gradient(700px 420px at -10% 110%, rgba(6,182,212,.10), transparent 60%),
    #f6faf8 !important;
}
.block-container { padding: 2rem 2.4rem 3rem !important; }

/* ---------- Sidebar ---------- */
[data-testid="stSidebar"] {
  background: linear-gradient(180deg, #064e3b 0%, #065f46 55%, #047857 100%) !important;
  box-shadow: 6px 0 30px rgba(6,78,59,.25) !important;
}
.nav-logo { border-bottom: 1px solid rgba(255,255,255,.12) !important; padding: 28px 20px 20px !important; }
.nav-logo-name {
  font-size: 1.2rem !important; font-weight: 800 !important; letter-spacing: -.01em !important;
  background: linear-gradient(90deg, #ffffff, #a7f3d0);
  -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent;
}
.nav-logo-name::before { content: "📊 "; -webkit-text-fill-color: initial; }
.nav-section { color: #6ee7b7 !important; letter-spacing: .16em !important; }

[data-testid="stSidebar"] [data-testid="stRadio"] label {
  background: transparent !important;
  border: 1px solid transparent !important;
  border-radius: 12px !important;
  padding: 11px 16px !important;
  color: #d1fae5 !important;
  backdrop-filter: blur(4px);
}
[data-testid="stSidebar"] [data-testid="stRadio"] label:hover {
  background: rgba(255,255,255,.10) !important;
  border-color: rgba(255,255,255,.18) !important;
  transform: translateX(5px) !important;
}
[data-testid="stSidebar"] [data-testid="stRadio"] label:has(input:checked) {
  background: linear-gradient(135deg, #34d399 0%, #10b981 100%) !important;
  color: #022c22 !important;
  font-weight: 700 !important;
  border: none !important;
  border-left: none !important;
  box-shadow: 0 8px 20px rgba(0,0,0,.25) !important;
  transform: translateX(3px) !important;
}
.upgrade-box {
  background: rgba(255,255,255,.10) !important;
  border: 1px solid rgba(255,255,255,.22) !important;
  backdrop-filter: blur(10px);
  border-radius: 16px !important;
}

/* ---------- Page headings ---------- */
.page-title {
  font-size: 2rem !important; font-weight: 800 !important; letter-spacing: -.035em !important;
  background: linear-gradient(90deg, var(--brand-deep), var(--brand) 70%, var(--accent));
  -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent;
}
.page-sub { font-size: .9rem !important; color: var(--muted) !important; }
.section-title { font-size: 1.05rem !important; font-weight: 700 !important; letter-spacing: -.01em; }

/* ---------- KPI metric cards ---------- */
[data-testid="stMetric"] {
  background: linear-gradient(160deg, #ffffff 0%, #f3fbf7 100%) !important;
  border: 1px solid var(--line) !important;
  border-radius: var(--radius) !important;
  padding: 22px 24px !important;
  box-shadow: var(--shadow) !important;
}
[data-testid="stMetric"]:hover { box-shadow: var(--shadow-hov) !important; transform: translateY(-4px) !important; }
[data-testid="stMetric"]::before {
  height: 4px !important;
  background: linear-gradient(90deg, var(--brand), var(--accent)) !important;
}
[data-testid="stMetric"]::after {
  content: ""; position: absolute; right: -30px; top: -30px; width: 110px; height: 110px;
  background: radial-gradient(circle, rgba(16,185,129,.18), transparent 70%); border-radius: 50%;
}
[data-testid="stMetricLabel"] { text-transform: uppercase; letter-spacing: .07em; font-size: .72rem !important; font-weight: 700 !important; }
[data-testid="stMetricValue"] { font-size: 2rem !important; font-weight: 800 !important; letter-spacing: -.03em; color: var(--ink) !important; }
[data-testid="stMetricDelta"] {
  background: rgba(16,185,129,.12); color: var(--brand-dark) !important;
  padding: 2px 10px; border-radius: 99px; width: fit-content; font-weight: 600 !important;
}

/* ---------- Bordered containers = cards ---------- */
[data-testid="stVerticalBlockBorderWrapper"] {
  background: rgba(255,255,255,.88) !important;
  border: 1px solid var(--line) !important;
  border-radius: var(--radius) !important;
  box-shadow: var(--shadow) !important;
  backdrop-filter: blur(8px);
  transition: box-shadow .25s ease, transform .25s ease;
}
[data-testid="stVerticalBlockBorderWrapper"]:hover { box-shadow: var(--shadow-hov) !important; }

/* ---------- Tabs ---------- */
[data-testid="stTabs"] [data-baseweb="tab-list"] {
  background: rgba(255,255,255,.8) !important; border: 1px solid var(--line) !important;
  border-radius: 14px !important; padding: 5px !important; gap: 4px !important; box-shadow: var(--shadow);
}
[data-testid="stTabs"] [data-baseweb="tab"] { border-radius: 10px !important; padding: 8px 20px !important; font-weight: 600 !important; }
[data-testid="stTabs"] [aria-selected="true"] {
  background: linear-gradient(135deg, var(--brand), var(--brand-dark)) !important;
  color: #fff !important; box-shadow: 0 6px 16px rgba(16,185,129,.35);
}
[data-testid="stTabs"] [data-baseweb="tab-highlight"],
[data-testid="stTabs"] [data-baseweb="tab-border"] { display: none !important; }

/* ---------- Tables ---------- */
.txn-table th {
  background: #f1f8f5; color: var(--brand-dark) !important; border-bottom: none !important;
  font-weight: 700 !important;
}
.txn-table th:first-child { border-radius: 10px 0 0 10px; }
.txn-table th:last-child  { border-radius: 0 10px 10px 0; }
.txn-table td { border-bottom: 1px solid rgba(15,23,42,.05) !important; padding: 13px 14px !important; }
.txn-table tr:hover td { background: rgba(16,185,129,.07) !important; }
.amount { color: var(--brand-dark) !important; }
[data-testid="stDataFrame"] { border-radius: 14px; overflow: hidden; border: 1px solid var(--line); }

/* ---------- Badges ---------- */
.badge-g, .badge-a, .badge-r, .badge-b { padding: 4px 12px !important; font-weight: 700 !important; letter-spacing: .02em; }
.badge-g { background: linear-gradient(135deg,#d1fae5,#a7f3d0) !important; color: #065f46 !important; }

/* ---------- Progress bars ---------- */
.prog-bar-wrap { height: 8px !important; background: #e6f4ee !important; }
.prog-bar-fill { background: linear-gradient(90deg, var(--brand), var(--accent)) !important; }

/* ---------- Buttons / inputs ---------- */
.stButton > button, .stDownloadButton > button {
  border-radius: 12px !important; font-weight: 600 !important; padding: 8px 20px !important;
  border: 1px solid rgba(16,185,129,.35) !important; color: var(--brand-dark) !important;
  background: #fff !important; transition: all .2s ease !important;
}
.stButton > button:hover, .stDownloadButton > button:hover {
  background: linear-gradient(135deg, var(--brand), var(--brand-dark)) !important;
  color: #fff !important; border-color: transparent !important;
  box-shadow: 0 8px 20px rgba(16,185,129,.35) !important; transform: translateY(-2px);
}
[data-baseweb="select"] > div, [data-testid="stFileUploader"] section {
  border-radius: 12px !important; border-color: rgba(16,185,129,.3) !important;
}
[data-testid="stFileUploader"] section { background: rgba(16,185,129,.05) !important; border-style: dashed !important; }
[data-testid="stAlert"] { border-radius: 14px !important; border: 1px solid var(--line) !important; }

::-webkit-scrollbar-thumb { background: linear-gradient(var(--brand), var(--accent)) !important; }
</style>
"""

try:
    # Run the original dashboard exactly as it is.
    runpy.run_path(str(HERE / "demo_app.py"), run_name="__main__")
finally:
    # Apply the new look on top (later CSS wins over the original CSS).
    st.markdown(SKIN, unsafe_allow_html=True)