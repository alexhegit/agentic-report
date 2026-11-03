import importlib.util
import unittest
from pathlib import Path


REPO = Path(__file__).resolve().parents[1]


def load_ingest_module():
    spec = importlib.util.spec_from_file_location("agentic_ingest", REPO / "scripts" / "ingest.py")
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class ScoutIngestContractTests(unittest.TestCase):
    def test_physical_ai_scout_streams_have_ingest_metadata(self):
        ingest = load_ingest_module()

        self.assertEqual(
            ingest.JOBS["physical-ai-daily-scout"],
            ("physical-ai", "日报", "Physical AI Daily Scout"),
        )
        self.assertEqual(
            ingest.JOBS["physical-ai-arxiv-scout"],
            ("physical-ai", "论文监测", "Physical AI 高质量论文监测"),
        )
        self.assertEqual(
            ingest.JOBS["physical-ai-github-scout"],
            ("physical-ai", "项目监测", "GitHub Physical AI 项目监测"),
        )
        self.assertEqual(
            ingest.JOBS["physical-ai-industry-watch"],
            ("physical-ai", "行业监测", "Physical AI Industry Watch"),
        )
        self.assertEqual(
            ingest.JOBS["physical-ai-weekly-synthesis"],
            ("physical-ai", "周度综合", "Physical AI Weekly Synthesis"),
        )

    def test_default_view_shows_recent_reports_without_forcing_latest_date(self):
        html = (REPO / "index.html").read_text(encoding="utf-8")
        load_body = html.split("async function load(){", 1)[1].split("\nfunction esc", 1)[0]

        self.assertNotIn("selectDate(latest)", load_body)

    def test_frontend_has_english_labels_for_scout_streams(self):
        html = (REPO / "index.html").read_text(encoding="utf-8")

        self.assertIn("'论文监测':'Paper Scout'", html)
        self.assertIn("'项目监测':'Project Scout'", html)
        self.assertIn("'行业监测':'Industry Watch'", html)
        self.assertIn("'周度综合':'Weekly Synthesis'", html)


if __name__ == "__main__":
    unittest.main()
