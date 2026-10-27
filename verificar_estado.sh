#!/usr/bin/env bash
# Verificación de avance de la práctica EcoTrack Meta.
# Uso: bash verificar_estado.sh

cd "$(dirname "$0")" || exit 1

pendientes=0

ok() {
  printf 'OK     %s\n' "$1"
}

falta() {
  printf 'FALTA  %s\n' "$1"
  pendientes=$((pendientes + 1))
}

archivo() {
  if [ -f "$1" ]; then
    ok "archivo $1"
  else
    falta "archivo $1"
  fi
}

contiene() {
  if grep -Fq "$2" "$1" 2>/dev/null; then
    ok "$1 contiene $3"
  else
    falta "$1 contiene $3"
  fi
}

echo "== Etapa 0: proyecto base =="
contiene pubspec.yaml 'name: ecotrack_meta' 'name: ecotrack_meta'
contiene pubspec.yaml 'provider:' 'dependencia provider'
[ -d test ] && ok 'carpeta test del kit' || falta 'carpeta test del kit'
[ -d lib/dominio ] && ok 'carpeta lib/dominio' || falta 'carpeta lib/dominio'
[ -d lib/datos ] && ok 'carpeta lib/datos' || falta 'carpeta lib/datos'
[ -d lib/presentacion ] && ok 'carpeta lib/presentacion' || falta 'carpeta lib/presentacion'
[ -d lib/variantes ] && ok 'carpeta lib/variantes' || falta 'carpeta lib/variantes'
[ -d docs ] && ok 'carpeta docs' || falta 'carpeta docs'

echo
echo "== Etapa 1: dominio =="
archivo lib/dominio/consumo.dart
archivo lib/dominio/meta.dart
contiene lib/dominio/consumo.dart 'laboratoriosUtez' 'laboratoriosUtez'
contiene lib/dominio/consumo.dart 'class Consumo' 'class Consumo'
contiene lib/dominio/consumo.dart 'validarLitros' 'validarLitros'
contiene lib/dominio/consumo.dart 'Escribe los litros con número' 'mensaje de número'
contiene lib/dominio/consumo.dart 'Los litros deben ser mayores que cero' 'mensaje de cero'
contiene lib/dominio/consumo.dart 'Los litros superan el tope de 10000' 'mensaje de tope'
contiene lib/dominio/meta.dart 'metaInicial' 'metaInicial'
contiene lib/dominio/meta.dart 'pasoMeta' 'pasoMeta'
contiene lib/dominio/meta.dart 'metaMinima' 'metaMinima'
contiene lib/dominio/meta.dart 'ajustarMeta' 'ajustarMeta'
contiene lib/dominio/meta.dart 'avanceDeMeta' 'avanceDeMeta'

echo
echo "== Etapa 2: datos =="
archivo lib/datos/consumo_repository.dart
archivo lib/datos/memoria_consumo_repository.dart
contiene lib/datos/consumo_repository.dart 'abstract class ConsumoRepository' 'contrato ConsumoRepository'
contiene lib/datos/consumo_repository.dart 'Future<void> guardar' 'guardar'
contiene lib/datos/consumo_repository.dart 'Future<List<Consumo>> todos' 'todos'
contiene lib/datos/memoria_consumo_repository.dart 'implements ConsumoRepository' 'implementación del contrato'
contiene lib/datos/memoria_consumo_repository.dart 'List.unmodifiable' 'copia no modificable'

echo
echo "== Etapa 3: ViewModel =="
archivo lib/presentacion/consumos_view_model.dart
contiene lib/presentacion/consumos_view_model.dart 'extends ChangeNotifier' 'extends ChangeNotifier'
contiene lib/presentacion/consumos_view_model.dart 'double get total' 'getter total'
contiene lib/presentacion/consumos_view_model.dart 'double get avance' 'getter avance'
contiene lib/presentacion/consumos_view_model.dart 'bool get metaSuperada' 'getter metaSuperada'
contiene lib/presentacion/consumos_view_model.dart 'Future<void> cargar' 'cargar'
contiene lib/presentacion/consumos_view_model.dart 'Future<bool> guardar' 'guardar'
contiene lib/presentacion/consumos_view_model.dart 'void subirMeta' 'subirMeta'
contiene lib/presentacion/consumos_view_model.dart 'void bajarMeta' 'bajarMeta'
contiene lib/presentacion/consumos_view_model.dart 'notifyListeners' 'notifyListeners'

echo
echo "== Etapa 4: vistas tontas y variante A =="
archivo lib/presentacion/vistas.dart
archivo lib/variantes/a_change_notifier.dart
archivo lib/main_change_notifier.dart
contiene lib/presentacion/vistas.dart 'class FormularioRegistro' 'FormularioRegistro'
contiene lib/presentacion/vistas.dart 'class ListaHistorial' 'ListaHistorial'
contiene lib/presentacion/vistas.dart 'class PanelMeta' 'PanelMeta'
contiene lib/presentacion/vistas.dart 'class PantallasEcoTrack' 'PantallasEcoTrack'
contiene lib/presentacion/vistas.dart "Key('litros')" 'Key litros'
contiene lib/presentacion/vistas.dart "Key('bajarMeta')" 'Key bajarMeta'
contiene lib/presentacion/vistas.dart "Key('subirMeta')" 'Key subirMeta'
contiene lib/presentacion/vistas.dart 'IndexedStack' 'IndexedStack'
contiene lib/variantes/a_change_notifier.dart 'class AppChangeNotifier' 'AppChangeNotifier'
contiene lib/variantes/a_change_notifier.dart 'class RegistroCN' 'RegistroCN'
contiene lib/variantes/a_change_notifier.dart 'class HistorialCN' 'HistorialCN'
contiene lib/variantes/a_change_notifier.dart 'class MetaCN' 'MetaCN'
contiene lib/variantes/a_change_notifier.dart 'ListenableBuilder' 'ListenableBuilder'
contiene lib/variantes/a_change_notifier.dart 'dispose()' 'dispose del ViewModel'

echo
echo "== Etapa 5: provider =="
archivo lib/variantes/b_provider.dart
contiene lib/variantes/b_provider.dart 'class AppProvider' 'AppProvider'
contiene lib/variantes/b_provider.dart 'class RegistroProvider' 'RegistroProvider'
contiene lib/variantes/b_provider.dart 'class HistorialProvider' 'HistorialProvider'
contiene lib/variantes/b_provider.dart 'class MetaProvider' 'MetaProvider'
contiene lib/variantes/b_provider.dart 'ChangeNotifierProvider' 'ChangeNotifierProvider'
contiene lib/variantes/b_provider.dart 'context.watch' 'context.watch'
contiene lib/variantes/b_provider.dart 'context.read' 'context.read'
contiene lib/main.dart 'AppProvider' 'main usa AppProvider'

echo
echo "== Etapa 6: docs/estado.md =="
archivo docs/estado.md
contiene docs/estado.md 'Elegimos:' 'decisión final'
contiene docs/estado.md 'Tipos de estado' 'tabla de tipos de estado'
contiene docs/estado.md 'Sustitución de la fuente de datos' 'criterio de sustitución'

echo
if [ "$pendientes" -eq 0 ]; then
  echo "RESULTADO: todo en OK."
  exit 0
else
  echo "RESULTADO: $pendientes comprobaciones en FALTA."
  exit 1
fi
