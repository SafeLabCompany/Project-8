# Cadeia de Frio — Monitoramento de Vacinas (Grupo 8)

## Descrição do projeto

Sistema de monitoramento em tempo real da cadeia de frio de vacinas e imunobiológicos,
mantendo refrigeradores na faixa regulatória de 2°C a 8°C. Utiliza um microcontrolador
Arduino UNO R3 com sensor de temperatura LM35 de alta precisão, integrado a uma interface web com alertas automáticos e histórico para auditoria.

## Funcionalidades

✔️ Leitura contínua de temperatura (intervalo de 2 segundos) <br>
✔️ Alertas automáticos em caso de oscilação fora da faixa segura (2-8°C) <br>
✔️ Dashboard web em tempo real <br>
✔️ Armazenamento histórico em banco de dados SQL, para auditorias

## Ferramentas utilizadas

Arduino UNO R3 <br>
Sensor LM35 <br>
MySQL <br>
Trello -> https://trello.com/b/JzjiuVPV/sprint-2-projeto-de-pi-grupo-8 <br>
VirtualBox -> Lubuntu

### Tecnologias utilizadas

<div style="display: flex; gap: 10px;">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL" />
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black" alt="JavaScript" />
  <img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white" alt="HTML5" />
  <img src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white" alt="CSS3" />
</div>

## Estrutura do repositório

- **`src/`** — projeto principal do grupo (banco de dados, documentação, protótipo)
- **`docs/`** — histórico de entregáveis
- **`docs/sprint#`** - histórico destinado a cada sprint

```
.
├── docs/
│   └── sprint1/
│       ├── coletivo/
│       └── Individuais/
├── src/
└── README.md
```

## Equipe

<table>
  <tr>
    <td align="center"><img src="https://github.com/EnzoMiyagi1.png" width="80"><br><a href="https://github.com/EnzoMiyagi1">Enzo Miyagi</a><br>[cargo]</td>
    <td align="center"><img src="https://github.com/FernandoSigueta.png" width="80"><br><a href="https://github.com/FernandoSigueta">Fernando Sigueta</a><br>[cargo]</td>
    <td align="center"><img src="https://github.com/Gfalcao25.png" width="80"><br><a href="https://github.com/Gfalcao25">Gabriel Falcão</a><br>[cargo]</td>
    <td align="center"><img src="https://github.com/MatheusOFrancisco.png" width="80"><br><a href="https://github.com/MatheusOFrancisco">Matheus Francisco</a><br>[cargo]</td>
  </tr>
  <tr>
    <td align="center"><img src="https://github.com/MVentura01.png" width="80"><br><a href="https://github.com/MVentura01">Mateus Ventura</a><br>[cargo]</td>
    <td align="center"><img src="https://github.com/vinikenzosptech.png" width="80"><br><a href="https://github.com/vinikenzosptech">Vinicius Kenzo</a><br>[cargo]</td>
    <td align="center"><img src="https://github.com/Leandro-TechDev.png" width="80"><br><a href="https://github.com/Leandro-TechDev">Leandro Ramos de Oliveira</a><br>[cargo]</td>
  </tr>
</table>
