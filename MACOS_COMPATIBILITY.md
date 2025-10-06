# Compatibilidad macOS - Intel y Apple Silicon

Este repositorio de dotfiles ahora es compatible con ambas arquitecturas de Mac:
- **Apple Silicon** (M1/M2/M3/M4): `/opt/homebrew`
- **Intel Mac**: `/usr/local`

## ¿Qué se modificó?

### 1. Detección automática de arquitectura

Todos los scripts y configuraciones ahora detectan automáticamente tu arquitectura Mac:

```bash
# En Bash/Shell
if [[ "$(uname -m)" == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"  # Apple Silicon
else
    HOMEBREW_PREFIX="/usr/local"      # Intel
fi
```

```lua
-- En Lua (wezterm)
local function get_homebrew_prefix()
    local handle = io.popen("uname -m")
    local arch = handle:read("*a"):gsub("%s+", "")
    handle:close()
    
    if arch == "arm64" then
        return "/opt/homebrew"
    else
        return "/usr/local"
    end
end
```

### 2. Archivos modificados

#### `install.sh`
- Detecta automáticamente la arquitectura al inicio del script
- Usa la variable `$HOMEBREW_PREFIX` para todas las rutas de Homebrew
- Configura correctamente las rutas de coreutils según tu Mac

#### `zsh/.zprofile`
- Detecta la arquitectura al cargar el shell
- Configura `$HOMEBREW_PREFIX` dinámicamente
- Actualiza las rutas de NVM y otros paquetes instalados por Homebrew
- Eliminadas rutas hardcoded de usuario específico (`/Users/personal`)

#### `zsh/.zshrc`
- Usa `$HOMEBREW_PREFIX` para cargar plugins de Zsh
- Configuración dinámica de zsh-autosuggestions y zsh-syntax-highlighting
- Rutas de Deno ahora usan `$HOME` en lugar de usuario hardcoded

#### `wezterm/wezterm.lua`
- Detecta la arquitectura al cargar la configuración
- Usa la ruta correcta para nvim según tu Mac
- Workspace configurado dinámicamente

#### `nvim/.config/nvim/lua/sethy/plugins/snacks.lua`
- Comentada la configuración de dashboard con imagen personal
- Los usuarios ahora deben personalizar su propia imagen

#### `README.md`
- Documentación actualizada explicando soporte para ambas arquitecturas
- Instrucciones claras sobre las diferencias entre Intel y Apple Silicon
- URLs de repositorio actualizadas a `dalonsogomez/dotfiles`

## Para usuarios de MacBook Air 2020 Intel

### Instalación

1. **Instalar Xcode Command Line Tools:**
   ```bash
   xcode-select --install
   ```

2. **Instalar Homebrew:**
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
   
   En Intel Mac, Homebrew se instalará en `/usr/local`

3. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/dalonsogomez/dotfiles.git $HOME/dotfiles
   cd $HOME/dotfiles
   ```

4. **Ejecutar el script de instalación:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

El script detectará automáticamente que estás usando un Mac Intel y configurará todas las rutas correctamente.

### Verificación

Después de la instalación, verifica que todo está correcto:

```bash
# Verificar que Homebrew está en la ruta correcta
which brew
# Debería mostrar: /usr/local/bin/brew

# Verificar que las variables están configuradas
echo $HOMEBREW_PREFIX
# Debería mostrar: /usr/local

# Verificar que los plugins de Zsh se cargan correctamente
echo $ZSH
```

## Diferencias clave entre arquitecturas

| Componente | Apple Silicon | Intel Mac |
|------------|--------------|-----------|
| Homebrew | `/opt/homebrew` | `/usr/local` |
| Brew binarios | `/opt/homebrew/bin` | `/usr/local/bin` |
| Coreutils | `/opt/homebrew/opt/coreutils` | `/usr/local/opt/coreutils` |
| NVM | `/opt/homebrew/opt/nvm` | `/usr/local/opt/nvm` |
| Arquitectura | `arm64` | `x86_64` |

## Troubleshooting

### Si los comandos no se encuentran después de la instalación

Recarga tu configuración de shell:
```bash
source ~/.zshrc
source ~/.zprofile
```

### Si Homebrew no se encuentra

Agrega manualmente a tu PATH:
```bash
# Para Intel Mac
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
```

### Si los plugins de Zsh no funcionan

Verifica que están instalados:
```bash
brew install zsh-autosuggestions zsh-syntax-highlighting
```

Y que las rutas son correctas en tu `.zshrc`:
```bash
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

## Personalización adicional

### Dashboard de Neovim con imagen personal

Si quieres agregar una imagen personalizada al dashboard de Neovim, edita el archivo:
`nvim/.config/nvim/lua/sethy/plugins/snacks.lua`

Descomenta y personaliza la sección:
```lua
{
    section = "terminal",
    cmd = "ascii-image-converter ~/path/to/your/image.jpg -C -c",
    random = 15,
    pane = 2,
    indent = 15,
    height = 20,
},
```

## Contribuciones

Si encuentras algún problema específico de tu arquitectura o tienes sugerencias de mejora, por favor abre un issue en GitHub.
