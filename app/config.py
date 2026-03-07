import os
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    """Application settings loaded from environment variables."""
    
    # Application settings
    MAX_FILE_SIZE_MB: int = 2

    # Azure OpenAI - Updated API version to latest stable
    AZURE_OPENAI_BASE_URL: str = os.getenv("AZURE_OPENAI_BASE_URL", "")
    AZURE_OPENAI_MODEL_DEPLOYMENT: str = os.getenv("AZURE_OPENAI_MODEL_DEPLOYMENT", "")
    AZURE_OPENAI_API_VERSION: str = os.getenv("AZURE_OPENAI_API_VERSION", "2024-12-01-preview")

    # Key Vault
    KEY_VAULT_URL: str = os.getenv("KEY_VAULT_URL", "")

    # For local development only - DO NOT use in production
    AZURE_OPENAI_API_KEY: str = os.getenv("AZURE_OPENAI_API_KEY", "")

    class Config:
        env_file = ".env"
        case_sensitive = False

settings = Settings()
