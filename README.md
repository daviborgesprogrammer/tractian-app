# Mobile Software Engineer

### Contexto

Os ativos são essenciais para a operação industrial, abrangendo desde equipamentos de fabricação até veículos de transporte e sistemas de geração de energia. A gestão e manutenção adequadas são cruciais para garantir que continuem operando de forma eficiente e eficaz. Uma forma prática de visualizar a hierarquia dos ativos é através de uma estrutura em árvore.

### Desafio

> 📌  **Construir um aplicativo de visualização em árvore que exiba os ativos de uma empresa** 
*(A árvore é basicamente composta por componentes, ativos e locais)*

**Componentes**

- Componentes são as partes que constituem um ativo.
- Componentes são tipicamente associados a um ativo, mas o cliente **pode** querer adicionar componentes sem um ativo pai **ou** com um local como pai
- Componentes geralmente incluem sensores de  **vibration** ou **energy**, e possuem um status de **operating** ou **alert**
- Na árvore, os componentes são representados por este ícone:
![component](assets/icons/component.png)
    

**Ativos/Sub-Ativos**

- Os ativos possuem um conjunto de componentes.
- Alguns ativos são muito grandes, como uma esteira transportadora, e **podem** conter N sub-ativos.
- Os ativos são tipicamente associados a um local, mas o cliente **pode** querer adicionar ativos sem especificar um local como pai.
- Você pode saber que um item é um **ativo** se ele tiver outros ativos ou componentes como filhos.
- Na árvore, os ativos são representados por este ícone:
![asset](assets/icons/asset.png)
    

**Locais/Sub-Locais**

- Locais representam os lugares onde os ativos estão localizados. Para locais muito grandes, o cliente pode querer dividi-los para manter sua hierarquia mais organizada. Portanto, locais podem conter N sub-locais.
- Na árvore, os locais são representados por este ícone:
![location](assets/icons/location.png)

Em resumo, uma árvore pode ter esta aparência:

```
- Raiz
  |
  └── Localização A 
  |     |
  |     ├── Ativo 1
  |     |     ├── Componente A1
  |     |     ├── Componente A2
  |     |
  |     ├── Ativo 2
  |           ├── Componente B1
  |           ├── Componente B2
  |
  ├── Localização B
  |     ├── Localização C
  |     |     |
  |     |     ├── Ativo 3
  |     |     |     ├── Componente C1
  |     |     |     ├── Componente C2
  |     |     |
  |     |     ├── Componente D1
  |
  └── Componente X
```

## Características

**1. Página inicial**

- É o menu para os usuários navegarem entre diferentes empresas e acessarem seus ativos.

**2. Página de ativos**

- A Árvore de Ativos é o recurso principal, oferecendo uma representação visual em árvore da hierarquia de ativos da empresa.
- **Sub-recursos:**
    1. **Visualização**
        - Apresente uma estrutura de árvore dinâmica exibindo componentes, ativos e locais.
    2. **Filtros**
        
        **Pesquisa de texto**
        
        - Os usuários podem pesquisar componentes/ativos/locais específicos na hierarquia de ativos.
        
        **Sensores de energia**
        
        - Implemente um filtro para isolar sensores de energia dentro da árvore.
        
        **Status crítico do sensor**
        
        - Integre um filtro para identificar ativos com status crítico de sensor.
    - Quando os filtros são aplicados, os pais dos ativos **não podem** ser ocultados. O usuário deve conhecer todo o caminho do ativo. Os itens que não estão relacionados ao caminho do ativo devem ser ocultados

### Dados Técnicos
Você tem Ativos e Locais, precisa relacionar ambos para construir a Árvore.

**Coleção de locais**

Contém apenas locais e sublocais (compostos por nome, id e um parentId opcional)
```json
{
  "id": "65674204664c41001e91ecb4",
  "name": "PRODUCTION AREA - RAW MATERIAL",
  "parentId": null
}
```

Se o local tiver um parentId, significa que é um sublocal
```json
{
  "id": "656a07b3f2d4a1001e2144bf",
  "name": "CHARCOAL STORAGE SECTOR",
  "parentId": "65674204664c41001e91ecb4"
}
```

A representação visual:
```
- PRODUCTION AREA - RAW MATERIAL
  |
  ├── CHARCOAL STORAGE SECTOR
```

    
**Coleção de ativos**

Contém ativos, subativos e componentes (compostos por name, id e um locationId opcional, parentId e sensorType)

Se o item tiver um sensorType, significa que é um componente. Se ele não tiver um local ou parentId, significa que ele não é diferente de nenhum ativo ou local na árvore.
```json
{
  "id": "656734821f4664001f296973",
  "name": "Fan - External",
  "parentId": null,
  "sensorId": "MTC052",
  "sensorType": "energy",
  "status": "operating",
  "gatewayId": "QHI640",
  "locationId": null
}
```

Se o item possui uma localização e não possui um sensorId, significa que ele é um ativo com uma localização como pai, da coleção de localização
```json
{
  "id": "656a07bbf2d4a1001e2144c2",
  "name": "CONVEYOR BELT ASSEMBLY",
  "locationId": "656a07b3f2d4a1001e2144bf"
}
```

Se o item tiver um parentId e não tiver um sensorId, significa que ele é um ativo com outro ativo como pai
```json
{
  "id": "656a07c3f2d4a1001e2144c5",
  "name": "MOTOR TC01 COAL UNLOADING AF02",
  "parentId": "656a07bbf2d4a1001e2144c2"
}
```

Se o item tiver um sensorType, significa que é um componente. Se tiver um location ou um parentId, significa que ele tem um asset ou Location como pai  
```json
{
  "id": "656a07cdc50ec9001e84167b",
  "name": "MOTOR RT COAL AF01",
  "parentId": "656a07c3f2d4a1001e2144c5",
  "sensorId": "FIJ309",
  "sensorType": "vibration",
  "status": "operating",
  "gatewayId": "FRH546"
}
```
        
Para resumir, esta é a representação visual destes itens na Árvore
```
- ROOT
  |
  ├── PRODUCTION AREA - RAW MATERIAL [Location]
  |     |
  |     ├── CHARCOAL STORAGE SECTOR [Sub-Location]
  |     |     |
  |     |     ├── CONVEYOR BELT ASSEMBLY [Asset]
  |     |     |     |
  |     |     |     ├── MOTOR TC01 COAL UNLOADING AF02 [Sub-Asset]
  |     |     |     |     |
  |     |     |     |     ├── MOTOR RT COAL AF01 [Component - Vibration]
  |
  ├── Fan - External [Component - Vibration]
```

### Design
[Figma Link](https://www.figma.com/file/IP50SSLkagXsUNWiZj0PjP/%5BCareers%5D-Flutter-Challenge-v2?type=design&node-id=0%3A1&mode=design&t=puUgGuBG9v8leaSQ-1)

> 💡 Você não precisa corresponder exatamente ao design do figma! Por favor, consiga abstrair bem o problema apresentado e defina você mesmo o que considera mais importante e pense com a cabeça do usuário!


### Demo API
A API só funciona para requisições GET, há 3 endpoints:

- `/companies` - Retorna todas as empresas
- `/companies/:companyId/locations` - Retorna todos os locais da empresa
- `/companies/:companyId/assets` - Retorna todos os ativos da empresa

API: [fake-api.tractian.com](fake-api.tractian.com)

### No README
- Incluir um vídeo demonstrando a abertura do aplicativo para cada empresa e selecionando um filtro.
- Descreva quais pontos do projeto você melhoraria se tivesse mais tempo.

### Extra
Você pode usar bibliotecas para qualquer coisa que achar essencial, **exceto** para a Asset Tree e a UI.
Neste desafio, desempenho e usabilidade contam como pontos de **bônus**.

## Versões do README
[Português BR](./README.md) | [Ingles US](./README-en.md)