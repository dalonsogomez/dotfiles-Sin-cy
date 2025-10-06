# Guía de Instalación para MacBook Air 2020 (Intel)

## ✅ Cambios Realizados

Tu repositorio de dotfiles ahora es **totalmente compatible** con MacBook Air 2020 (chip Intel). Los cambios implementados detectan automáticamente la arquitectura de tu Mac y configuran las rutas correctas.

### Diferencia Principal:
- **Apple Silicon (M1/M2/M3)**: Homebrew se instala en `/opt/homebrew`
- **Intel Mac (tu caso)**: Homebrew se instala en `/usr/local` ✅

## 📋 Pasos de Instalación en tu MacBook Air 2020

### 1. Instalar Xcode Command Line Tools
```bash
xcode-select --install
```
Presiona "Instalar" cuando aparezca la ventana emergente.

### 2. Instalar Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
⚠️ **Importante**: En tu Mac Intel, Homebrew se instalará automáticamente en `/usr/local`

### 3. Clonar tu repositorio de dotfiles
```bash
cd $HOME
git clone https://github.com/dalonsogomez/dotfiles.git
cd dotfiles
```

### 4. Ejecutar el script de instalación
```bash
chmod +x install.sh
./install.sh
```

El script detectará automáticamente que tienes un Mac Intel y:
- ✅ Configurará Homebrew en `/usr/local`
- ✅ Instalará todos los paquetes necesarios
- ✅ Configurará las rutas correctas en tu shell
- ✅ Usará GNU stow para crear los symlinks

### 5. Recargar tu configuración de shell
```bash
source ~/.zshrc
source ~/.zprofile
```

## 🔍 Verificación

Después de la instalación, verifica que todo funciona correctamente:

### Verificar Homebrew
```bash
which brew
# Debe mostrar: /usr/local/bin/brew
```

### Verificar que se detectó Intel
```bash
uname -m
# Debe mostrar: x86_64
```

### Verificar variables de entorno
```bash
echo $HOMEBREW_PREFIX
# Debe mostrar: /usr/local
```

### Verificar que los comandos funcionan
```bash
# Probar neovim
nvim --version

# Probar starship
starship --version

# Probar tmux
tmux -V

# Probar fzf
fzf --version
```

## 📁 Archivos Modificados

Los siguientes archivos ahora detectan automáticamente tu arquitectura:

1. **`install.sh`**
   - Detecta si tu Mac es Intel o Apple Silicon al inicio
   - Usa la variable `$HOMEBREW_PREFIX` para todas las instalaciones

2. **`zsh/.zprofile`**
   - Detecta la arquitectura cada vez que abres un terminal
   - Configura las rutas de Homebrew dinámicamente
   - Configura NVM, coreutils, y otros paquetes con la ruta correcta

3. **`zsh/.zshrc`**
   - Usa `$HOMEBREW_PREFIX` para cargar plugins
   - Elimina rutas hardcoded específicas de usuario

4. **`wezterm/wezterm.lua`**
   - Detecta la arquitectura para configurar nvim
   - Funciona en ambas arquitecturas sin cambios manuales

5. **`README.md`**
   - Actualizado con documentación para ambas arquitecturas
   - Instrucciones claras sobre las diferencias

6. **`nvim/.config/nvim/lua/sethy/plugins/snacks.lua`**
   - Removidas rutas hardcoded personales
   - Listo para personalizar con tus propias rutas

## ⚙️ Personalización Adicional

### Configurar tu propia imagen en Neovim Dashboard

Si quieres añadir una imagen personalizada en el dashboard de Neovim:

1. Edita: `nvim/.config/nvim/lua/sethy/plugins/snacks.lua`
2. Busca la sección comentada del dashboard
3. Descomenta y cambia la ruta de la imagen:
   ```lua
   {
       section = "terminal",
       cmd = "ascii-image-converter ~/ruta/a/tu/imagen.jpg -C -c",
       random = 15,
       pane = 2,
       indent = 15,
       height = 20,
   },
   ```

### Rutas de Scripts

El repositorio usa rutas relativas a tu `$HOME`:
- Scripts: `~/scripts/`
- Dotfiles: `~/dotfiles/`
- Config: `~/.config/`

Estas rutas funcionan sin importar tu nombre de usuario.

## 🐛 Solución de Problemas

### Los comandos no se encuentran después de instalar

```bash
# Recargar la configuración
source ~/.zshrc
source ~/.zprofile

# Verificar que Homebrew está en el PATH
echo $PATH | grep "/usr/local"
```

### Los plugins de Zsh no funcionan

```bash
# Verificar que están instalados
ls /usr/local/share/zsh-autosuggestions
ls /usr/local/share/zsh-syntax-highlighting

# Si no están, instalarlos manualmente
brew install zsh-autosuggestions zsh-syntax-highlighting
```

### Stow falla al crear symlinks

```bash
# Asegurarse de que .config existe
mkdir -p ~/.config

# Volver a ejecutar stow
cd ~/dotfiles
stow -t ~ aerospace karabiner neovim starship wezterm tmux zsh
```

## 📚 Documentación Adicional

Para más detalles sobre la compatibilidad entre arquitecturas, consulta:
- `MACOS_COMPATIBILITY.md` - Documentación técnica completa
- `README.md` - Instrucciones generales de instalación

## ✨ Resumen

**¡Todo listo!** Tu repositorio de dotfiles ahora:
- ✅ Detecta automáticamente tu MacBook Air 2020 Intel
- ✅ Configura Homebrew en `/usr/local` correctamente
- ✅ Usa rutas dinámicas en todos los archivos de configuración
- ✅ No tiene rutas hardcoded que puedan causar problemas
- ✅ Es totalmente portable entre Intel y Apple Silicon

Solo ejecuta `./install.sh` y todo se configurará automáticamente para tu Mac Intel.

---

**Fecha de actualización**: 2024
**Compatible con**: macOS Intel (x86_64) y Apple Silicon (arm64)
