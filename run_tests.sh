#!/bin/bash

install_lcov() {
    if command -v lcov >/dev/null 2>&1; then
        echo "✅ lcov ya está instalado."
    else
        echo "⬇️  lcov no está instalado. Instalando..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if [ -f /etc/debian_version ]; then
                # Ubuntu/Debian
                sudo apt-get update -qq -y
                sudo apt-get install lcov -y
            elif [ -f /etc/redhat-release ]; then
                # CentOS/RedHat/Fedora
                sudo yum install lcov -y
            else
                echo "⚠️  Distribución Linux no soportada. Por favor, instala lcov manualmente."
                exit 1
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            # MacOS
            if command -v brew >/dev/null 2>&1; then
                brew install lcov
            else
                echo "⬇️  Homebrew no está instalado. Instalando Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                brew install lcov
            fi
        else
            echo "⚠️  SO no soportado para la instalación automática de lcov."
            exit 1
        fi
    fi
}

generate_coverage() {
    echo "🚀 Ejecutando pruebas y generando archivos de coverage..."
    flutter test --coverage
    echo "📊 Generando informe HTML de coverage..."
    genhtml coverage/lcov.info -o coverage/html
    echo "✅ Informe de coverage generado en coverage/html/index.html"
}

open_coverage_report() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open coverage/html/index.html
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        xdg-open coverage/html/index.html
    else
        echo "🌐 Por favor, abre coverage/html/index.html manualmente en tu navegador."
    fi
}

install_lcov
generate_coverage
open_coverage_report