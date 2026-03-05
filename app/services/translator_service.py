import os
import logging
from app.config import settings
from typing import Optional
from openai import AsyncAzureOpenAI
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

logger = logging.getLogger("app.services.translator_service")

def get_openai_api_key() -> Optional[str]:
    """
    Retrieve OpenAI API key from Key Vault or environment.
    
    For production (Azure Web App with Managed Identity):
    - Fetches secret from Key Vault using Managed Identity
    
    For local development:
    - Uses AZURE_OPENAI_API_KEY from .env file
    
    Returns:
        API key string or None if not found
    """
    if settings.AZURE_OPENAI_API_KEY:
        logger.info("Using API key from environment variable (local dev)")
        return settings.AZURE_OPENAI_API_KEY
    
    if settings.KEY_VAULT_URL:
        try:
            logger.info("Attempting to fetch API key from Key Vault using Managed Identity")
            credential = DefaultAzureCredential()
            client = SecretClient(vault_url=settings.KEY_VAULT_URL, credential=credential)
            secret = client.get_secret("AZURE-OPENAI-API-KEY")
            logger.info("Successfully retrieved API key from Key Vault")
            return secret.value
        except Exception as e:
            logger.error(f"Failed to get secret from Key Vault: {e}")
            return None
    
    logger.warning("No API key source configured (neither env var nor Key Vault)")
    return None

async def translate_text(text: str, source_lang: str, target_lang: str) -> str:
    """
    Translate text using Azure OpenAI Chat Completion API.
    
    Uses the latest openai SDK (v1+) with AsyncAzureOpenAI client.
    
    Args:
        text: Text to translate
        source_lang: Source language code (e.g., "en")
        target_lang: Target language code (e.g., "pt-BR")
    
    Returns:
        Translated text string
    
    Raises:
        RuntimeError: If configuration is missing or translation fails
    """
    api_key = get_openai_api_key()
    
    if not settings.AZURE_OPENAI_BASE_URL or not settings.AZURE_OPENAI_MODEL_DEPLOYMENT:
        raise RuntimeError("Azure OpenAI configuration missing (AZURE_OPENAI_BASE_URL or AZURE_OPENAI_MODEL_DEPLOYMENT)")
    
    if not api_key:
        raise RuntimeError("Azure OpenAI API key not found (check Key Vault or .env file)")

    # Initialize AsyncAzureOpenAI client (openai SDK v1+)
    # Normalize endpoint to avoid double slashes in request URLs.
    azure_endpoint = settings.AZURE_OPENAI_BASE_URL.rstrip("/")
    client = AsyncAzureOpenAI(
        api_key=api_key,
        api_version=settings.AZURE_OPENAI_API_VERSION,
        azure_endpoint=azure_endpoint
    )

    prompt = (
        f"Translate the following text from {source_lang} to {target_lang}. "
        "Keep the meaning, do not invent or summarize. Only return the translated text.\n\n"
        f"{text}"
    )

    try:
        logger.info(f"Sending translation request to Azure OpenAI (model: {settings.AZURE_OPENAI_MODEL_DEPLOYMENT})")
        
        response = await client.chat.completions.create(
            model=settings.AZURE_OPENAI_MODEL_DEPLOYMENT,
            messages=[
                {"role": "system", "content": f"You are a professional translator from {source_lang} to {target_lang}."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.2,
            max_tokens=2048,
            timeout=60.0
        )
        
        translated = response.choices[0].message.content.strip()
        logger.info(f"Translation successful (input: {len(text)} chars, output: {len(translated)} chars)")
        return translated
        
    except Exception as e:
        logger.error(f"OpenAI translation failed: {e}", exc_info=True)
        raise RuntimeError(f"Translation failed: {str(e)}")

