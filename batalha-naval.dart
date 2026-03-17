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

//cria o gerador de números aleatórios usado para sortear navios. Os navios são préviamente definidos pelo sistema.
  Random random = Random();

//gera coordenadas aleatórias para cada navio (Obs: pode ocorrer colisão aqui).
  Ponto navioTime1 = Ponto(random.nextInt(tamanho), random.nextInt(tamanho));
  Ponto navioTime2 = Ponto(random.nextInt(tamanho), random.nextInt(tamanho));

//placar dos times, que é incrementado quando um navio é acertado. O jogo termina quando um dos times acerta o navio do adversário.
  int placar1 = 0;
  int placar2 = 0;

//flag que controla o loop principal.
  bool jogo = true;

//tudo o que ocorre repetidamente até alguém acertar: mostrar tabuleiro, ler jogada do Time 1, checar, marcar, depois Time 2, etc.
  while (jogo) {

    mostrarTabuleiro(tabuleiro);

    print("${verde}TIME 1 - ataque${reset}"); //mensagem do turno

    stdout.write("Linha (0-15): "); //define as coordenadas da linha
    int linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna (0-15): "); //define as coordenadas da coluna
    int coluna = int.parse(stdin.readLineSync()!);

    if (linha == navioTime2.linha && coluna == navioTime2.coluna) {
      print("${verde}Time 1 acertou o navio!${reset}");
      tabuleiro[linha][coluna] = "X"; //se acertou, marca com X e incrementa o placar.
      placar1++;
      jogo = false;
    } else {
      tabuleiro[linha][coluna] = "O";// se errou, marca com O.
      print("${vermelho}Time 1 errou.${reset}");
    }

    if (!jogo) break; //se Time 1 acertou, sai do loop antes do turno do Time 2

    mostrarTabuleiro(tabuleiro); //exibe antes do turno do Time 2

    print("${amarelo}TIME 2 - ataque${reset}");

    stdout.write("Linha (0-15): "); //define as coordenadas da linha para o time 2
    linha = int.parse(stdin.readLineSync()!);

    stdout.write("Coluna (0-15): "); //define as coordenadas da coluna para o time 2
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

//placar final impresso após terminado o jogo.
  print("\n${verde}===== PLACAR FINAL =====${reset}");
  print("Time 1: $placar1");
  print("Time 2: $placar2");

//mostra o tabuleiro
  mostrarTabuleiro(tabuleiro);
}

void mostrarTabuleiro(List<List<String>> tabuleiro) {

  print("");

  for (int i = 0; i < tabuleiro.length; i++) { //loop das linhas

    stdout.write(i.toString().padLeft(2) + " ");

    for (int j = 0; j < tabuleiro[i].length; j++) { //loop das colunas

      String valor = tabuleiro[i][j];

      if (valor == "X") { //se for X, imprime em vermelho, se for O, amarelo, senão azul.
        stdout.write("${vermelho}X${reset} ");
      } 
      else if (valor == "O") {
        stdout.write("${amarelo}O${reset} "); //marca os erros em amarelo para destacar, já que o mar é azul. O X é vermelho para destacar o acerto.
      } 
      else {
        stdout.write("${azul}~${reset} "); //mar é azul
      }

    }

    print("");
  }

  print("");
}