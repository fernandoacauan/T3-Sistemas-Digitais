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

![testbench_boa](https://github.com/user-attachments/assets/be3fdc2f-67d0-4b92-99e9-ebbd13250d22)

Tentando adicionar caso cheio:

![testbench_ruim](https://github.com/user-attachments/assets/cadd6afe-c125-469f-b86b-dc0fef9a6891)

O tamanho para em 8 (mesmo o testbench tentando adicionar mais), e "ignora" os inputs seguintes. Como pode ser visto no dataOut que só remove o ultimo elemento na posição 8.

## Testbench Deserializador

![deserializador](https://github.com/user-attachments/assets/7db93e78-3c35-4fb9-ae87-a70bd85f9427)

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
