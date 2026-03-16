import 'dart:io';
import 'dart:math';
import 'ponto.dart';

const azul = "\x1B[34m";
const vermelho = "\x1B[31m";
const amarelo = "\x1B[33m";
const verde = "\x1B[32m";
const reset = "\x1B[0m";

void main() {

  const tamanho = 16;

  List<List<String>> tabuleiro = List.generate(
    tamanho,
    (_) => List.generate(tamanho, (_) => "~"),
  );

  Random random = Random();

  Ponto navioTime1 = Ponto(random.nextInt(tamanho), random.nextInt(tamanho));
  Ponto navioTime2 = Ponto(random.nextInt(tamanho), random.nextInt(tamanho));

  int placar1 = 0;
  int placar2 = 0;

  bool jogo = true;

  while (jogo) {

    mostrarTabuleiro(tabuleiro);

    print("${verde}TIME 1 - ataque${reset}");

    stdout.write("Linha (0-15): ");
    int linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna (0-15): ");
    int coluna = int.parse(stdin.readLineSync()!);

    if (linha == navioTime2.linha && coluna == navioTime2.coluna) {
      print("${verde}Time 1 acertou o navio!${reset}");
      tabuleiro[linha][coluna] = "X";
      placar1++;
      jogo = false;
    } else {
      tabuleiro[linha][coluna] = "O";
      print("${vermelho}Time 1 errou.${reset}");
    }

    if (!jogo) break;

    mostrarTabuleiro(tabuleiro);

    print("${amarelo}TIME 2 - ataque${reset}");

    stdout.write("Linha (0-15): ");
    linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna (0-15): ");
    coluna = int.parse(stdin.readLineSync()!);

    if (linha == navioTime1.linha && coluna == navioTime1.coluna) {
      print("${amarelo}Time 2 acertou o navio!${reset}");
      tabuleiro[linha][coluna] = "X";
      placar2++;
      jogo = false;
    } else {
      tabuleiro[linha][coluna] = "O";
      print("${vermelho}Time 2 errou.${reset}");
    }
  }

  print("\n${verde}===== PLACAR FINAL =====${reset}");
  print("Time 1: $placar1");
  print("Time 2: $placar2");

  mostrarTabuleiro(tabuleiro);
}

void mostrarTabuleiro(List<List<String>> tabuleiro) {

  print("");

  for (int i = 0; i < tabuleiro.length; i++) {

    stdout.write(i.toString().padLeft(2) + " ");

    for (int j = 0; j < tabuleiro[i].length; j++) {

      String valor = tabuleiro[i][j];

      if (valor == "X") {
        stdout.write("${vermelho}X${reset} ");
      } 
      else if (valor == "O") {
        stdout.write("${amarelo}O${reset} ");
      } 
      else {
        stdout.write("${azul}~${reset} ");
      }

    }

    print("");
  }

  print("");
}