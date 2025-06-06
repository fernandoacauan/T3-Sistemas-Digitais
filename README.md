# T3 Sistemas Digitais




Este projeto contém a descrição de um sistema composto por um **Deserializador**, uma **Fila**, e uma **entidade de top** que conecta ambos. Também está incluso um **testbench** completo e um script `sim.do` para automação da simulação no ModelSim.



## Conteúdo



Neste repositório você encontrará:


- `deserializer.vhd`: Lê dados seriais e os converte para formato paralelo.
  
- `queue.vhd`: Implementa uma fila síncrona com operações de enqueue e dequeue.
  
- `top.vhd`: Entidade principal que integra os dois módulos acima.
  
- `tb.vhd`: Testbench completo para simular o sistema.

- `tbDeserializer.vhd`: Testbench do Deserializer.

- `tbQueue.vhd`: Testbench da Fila.
  
- `sim.do`: Script para uso com o ModelSim que compila os arquivos, executa a simulação e carrega os sinais.

## Testbench Fila

Funcionando:

![image](https://github.com/user-attachments/assets/e2683905-33c1-41c2-845a-5f9337eb2797)

Tentando adicionar caso cheio:

![image](https://github.com/user-attachments/assets/53e42d44-2590-4e01-9ea3-b48ad3e2a87f)

O tamanho para em 8 (mesmo o testbench tentando adicionar mais), e "ignora" os inputs seguintes. Como pode ser visto no dataOut que só remove o ultimo elemento na posicao 8.

## Testbench Deserializador

![image](https://github.com/user-attachments/assets/a7c79bd1-057a-4773-bb41-457ee3aa479c)

Antes de 400ns, temos o caso bom e após isso temos o caso ruim.

## Resultados Obtidos

Nós conseguimos construir o módulo da Fila e do Deserializador e seus respectivos testbenches. Contudo, encontramos problemas para passar a saída do deserializador para a entrada da fila. Com exceção desse problema,
todo resto do programa aparenta se comportar da forma como deveria em relação ao enunciado do trabalho.

## Requisitos

Para rodar este projeto, você deve ter o **ModelSim** instalado. O projeto utiliza a versão VHDL-2008.

## Como rodar a simulação



1. Abra o ModelSim.


2. Crie um novo projeto, adicione os arquivos deste repositorio.

3. Após criar o projeto, execute o seguinte comando no terminal: `do sim.do`
