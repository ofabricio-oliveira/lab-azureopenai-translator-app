import os
import logging
from fastapi import FastAPI, Request, UploadFile, File, Form, HTTPException
from fastapi.responses import FileResponse, HTMLResponse
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles
from starlette.background import BackgroundTasks
from app.config import settings
from app.services.pdf_service import extract_text_from_pdf, create_pdf_from_text
from app.services.translator_service import translate_text
from tempfile import NamedTemporaryFile
import shutil

app = FastAPI(title="Azure OpenAI PDF Translator LAB")

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("app")

# Static and template setup
app.mount("/static", StaticFiles(directory="app/static"), name="static")
templates = Jinja2Templates(directory="app/templates")

MAX_FILE_SIZE_MB = settings.MAX_FILE_SIZE_MB

@app.get("/", response_class=HTMLResponse)
async def index(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.post("/translate")
async def translate_pdf(
    request: Request,
    file: UploadFile = File(...),
    source_lang: str = Form("en"),
    target_lang: str = Form("pt-BR"),
    background_tasks: BackgroundTasks = None
):
    # Validate file type
    if not file.filename.lower().endswith(".pdf") or file.content_type != "application/pdf":
        logger.warning("Invalid file type uploaded.")
        raise HTTPException(status_code=400, detail="Only PDF files are allowed.")

    # Validate file size
    contents = await file.read()
    if len(contents) > MAX_FILE_SIZE_MB * 1024 * 1024:
        logger.warning("File too large.")
        raise HTTPException(status_code=400, detail=f"File too large. Max {MAX_FILE_SIZE_MB} MB allowed.")

    # Save uploaded file temporarily
    with NamedTemporaryFile(delete=False, suffix=".pdf") as temp_in:
        temp_in.write(contents)
        temp_in_path = temp_in.name

    try:
        # Extract text from PDF
        extracted_text = extract_text_from_pdf(temp_in_path)
        if not extracted_text.strip():
            logger.error("No text found in PDF.")
            raise HTTPException(status_code=400, detail="No text found in PDF.")

        # Translate text
        translated_text = await translate_text(extracted_text, source_lang, target_lang)

        # Create translated PDF
        with NamedTemporaryFile(delete=False, suffix=".pdf") as temp_out:
            create_pdf_from_text(translated_text, temp_out.name)
            temp_out_path = temp_out.name

        # Schedule temp files for deletion
        background_tasks.add_task(os.remove, temp_in_path)
        background_tasks.add_task(os.remove, temp_out_path)

        logger.info("Translation successful.")
        return FileResponse(
            temp_out_path,
            filename=f"translated_{file.filename}",
            media_type="application/pdf",
            background=background_tasks
        )
    except Exception as e:
        logger.exception("Translation failed.")
        raise HTTPException(status_code=500, detail=f"Translation failed: {str(e)}")
    finally:
        if os.path.exists(temp_in_path):
            os.remove(temp_in_path)
