1. urls.py 와 같은 레벨에 predChart 복붙
2. templates 폴더가 있다면 하위에 templates폴더 안의 내용 복붙
3. templates 폴더가 없다면 전체 복붙 => settings.py 내용 수정
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR,'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
4. urls.py 수정
5. views.py 수정