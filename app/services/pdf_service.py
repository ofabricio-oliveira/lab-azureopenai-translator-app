from typing import Optional
from pypdf import PdfReader
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter

def extract_text_from_pdf(pdf_path: str) -> str:
    """Extracts all text from a simple PDF file."""
    reader = PdfReader(pdf_path)
    text = ""
    for page in reader.pages:
        text += page.extract_text() or ""
    return text

def create_pdf_from_text(text: str, output_path: str):
    """Creates a simple PDF file from the given text."""
    c = canvas.Canvas(output_path, pagesize=letter)
    width, height = letter
    lines = text.splitlines()
    y = height - 40
    for line in lines:
        c.drawString(40, y, line)
        y -= 15
        if y < 40:
            c.showPage()
            y = height - 40
    c.save()
