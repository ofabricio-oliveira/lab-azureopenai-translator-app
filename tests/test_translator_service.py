import pytest
from app.services.translator_service import translate_text

import asyncio

@pytest.mark.asyncio
async def test_translate_text_mock(monkeypatch):
    async def mock_translate(text, source, target):
        return "Texto traduzido de exemplo."
    monkeypatch.setattr("app.services.translator_service.translate_text", mock_translate)
    result = await translate_text("Hello world", "en", "pt-BR")
    assert "exemplo" in result
