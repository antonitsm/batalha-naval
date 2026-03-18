import 'dart:io';
import 'dart:math';
import 'ponto.dart';

//definem as strings usadas para colorir o texto no terminal.
const azul = "\x1B[34m";
const vermelho = "\x1B[31m";
const amarelo = "\x1B[33m";
const verde = "\x1B[32m";
const reset = "\x1B[0m";

void main() {
//tamanho e criação do tabuleiro
  const tamanho = 16;

  List<List<String>> tabuleiro = List.generate(
    tamanho,
    (_) => List.generate(tamanho, (_) => "~"),
  );

// agora os próprios jogadores escolhem onde posicionar seus navios
// isso substitui o uso de posições aleatórias
  print("${verde}TIME 1 - escolha posição do navio${reset}");
  Ponto navioTime1 = lerPonto();

  print("${amarelo}TIME 2 - escolha posição do navio${reset}");
  Ponto navioTime2 = lerPonto();

//placar dos times, que é incrementado quando um navio é acertado. O jogo termina quando um dos times acerta o navio do adversário.
  int placar1 = 0;
  int placar2 = 0;

//flag que controla o loop principal.
  bool jogo = true;

//tudo o que ocorre repetidamente até alguém acertar: mostrar tabuleiro, ler jogada do Time 1, checar, marcar, depois Time 2, etc.
  while (jogo) {

    mostrarTabuleiro(tabuleiro);

    print("${verde}TIME 1 - ataque${reset}");

    Ponto ataque1 = lerPonto();

    if (ataque1.linha == navioTime2.linha &&
        ataque1.coluna == navioTime2.coluna) {
      print("${verde}Time 1 acertou o navio!${reset}");
      tabuleiro[ataque1.linha][ataque1.coluna] = "X";
      placar1++;
      jogo = false;
    } else {
      tabuleiro[ataque1.linha][ataque1.coluna] = "1"; // ataque time 1
      print("${vermelho}Time 1 errou.${reset}");
    }

    if (!jogo) break;

    mostrarTabuleiro(tabuleiro);

    print("${amarelo}TIME 2 - ataque${reset}");

    Ponto ataque2 = lerPonto();

    if (ataque2.linha == navioTime1.linha &&
        ataque2.coluna == navioTime1.coluna) {
      print("${amarelo}Time 2 acertou o navio!${reset}");
      tabuleiro[ataque2.linha][ataque2.coluna] = "X";
      placar2++;
      jogo = false;
    } else {
      tabuleiro[ataque2.linha][ataque2.coluna] = "2"; // ataque time 2
      print("${vermelho}Time 2 errou.${reset}");
    }
  }

//placar final impresso após terminado o jogo.
  print("\n${verde}===== PLACAR FINAL =====${reset}");
  print("Time 1: $placar1");
  print("Time 2: $placar2");

//mostra o tabuleiro
  mostrarTabuleiro(tabuleiro);
}

// função criada para evitar repetição de código ao ler coordenadas
Ponto lerPonto() {
  int linha;
  int coluna;

  while (true) {
    try {
      stdout.write("Linha (0-15): ");
      linha = int.parse(stdin.readLineSync()!);

      stdout.write("Coluna (0-15): ");
      coluna = int.parse(stdin.readLineSync()!);

      if (linha < 0 || linha > 15 || coluna < 0 || coluna > 15) {
        print("${vermelho}Erro: valores devem estar entre 0 e 15!${reset}");
        continue;
      }

      return Ponto(linha, coluna);

    } catch (e) {
      print("${vermelho}Erro: digite apenas números!${reset}");
    }
  }
}

// TABULEIRO COM NUMERAÇÃO EM CIMA E ALINHAMENTO CORRIGIDO
void mostrarTabuleiro(List<List<String>> tabuleiro) {

  print("");

  // topo (colunas)
  stdout.write("    ");
  for (int i = 0; i < tabuleiro.length; i++) {
    stdout.write(i.toString().padLeft(2) + " ");
  }
  print("");

  for (int i = 0; i < tabuleiro.length; i++) {

    // lateral (linhas)
    stdout.write(i.toString().padLeft(2) + "  ");

    for (int j = 0; j < tabuleiro[i].length; j++) {

      String valor = tabuleiro[i][j];

      if (valor == "X") {
        stdout.write("${vermelho}X${reset}  ");
      } 
      else if (valor == "1") {
        stdout.write("${verde}O${reset}  ");
      } 
      else if (valor == "2") {
        stdout.write("${amarelo}O${reset}  ");
      } 
      else {
        stdout.write("${azul}~${reset}  ");
      }

    }

    print("");
  }

  print("");
}