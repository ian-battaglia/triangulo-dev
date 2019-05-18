---
title: "Três hábitos para escrever CSS escalável"
excerpt: "O que você precisa saber para escrever CSS que escala junto com o seu projeto."
date: 2019-02-27T19:57:29-03:00
draft: true
---

Com cerca de 360 propriedades, não faltam muitas coisas para você conseguir
estilizar basicamente qualquer coisa usando a versão atual do CSS. O maior
problema na verdade está como solucionar problemas de estilização de uma forma
escalável. Escalável para que seu código seja flexível o suficiente para não
ter que ser completamente reescrito no próximo redesign que com certeza vai
acontecer, e também escalável para que seu time possa continuar mantendo
o código por muitos anos.

Em meio a tantos frameworks diferentes e técnicas como Flexbox, Grid CSS,
floats, e até CSS-in-JS, é difícil olhar através do superficial e achar as boas
práticas e hábitos essenciais para escrever CSS que dura.

Após muitos anos como desenvolvedor front-end acabei desenvolvendo alguns
hábitos que me levam a escrever CSS mais escalável. Agora, quase sempre que
encontro estilos difíceis de lidar ou que dão bastante trabalho para refatorar,
percebo que eles não seguem um dos três princípios básicos que vou te ensinar.

Aprender a escrever CSS escalável é muito útil pois, independente da sua
abordagem para criar interfaces de usuário na web, você vai precisar
estilizá-la. E, por mais bonita e bem planejada que seja, esta mesma interface
de usuário vai passar por muitas mudanças conforme o produto é alterado. Novas
funcionalidades precisam de espaço. O posicionamento de alguns elementos são
trocados para melhorar a experiência do usuário. Novas páginas são criadas.
Estilos mais "modernos" são propostos. Três hábitos podem nos ajudar a passar
por tudo isso com menos dor de cabeça.

## Abrir mão do posicionamento

Com CSS nós podemos posicionar qualquer elemento em qualquer lugar. Apesar
disso, não é sempre que devemos usar `position: fixed` ou `position: absolute`
para controlar exatamente em qual pixel na tela um elemento estará. Abrir mão
do posicionamento de um elemento vai ainda mais longe do que isso.

Cada vez que tentamos controlar o posicionamento de um elemento, este elemento
se torna menos reutilizável em diferentes contextos e talvez precise ser
refatorado quando o layout das páginas em que são utilizados forem alterados.

Vamos imaginar que temos uma galeria de imagens, composta por diversos
componentes `Figura`. Por componente, eu quero dizer um conjunto de HTML, CSS
e JS que trabalham juntos – usando ou não um framework. Cada `Figura` tem um
título, uma imagem e uma legenda. Quando estamos construindo o componente
`Figura` pode parecer fácil controlar o seu próprio posicionamento, já que
sabemos exatamente onde `Figura` será utilizado.

[image]

Porém, se pensarmos um pouco mais à fundo, a responsabilidade real do
componente `Figura` é estilizar uma combinação de título, imagem e legenda. Sua
posição na tela não é algo que é influenciado por estes atributos. Portanto,
faz sentido implementar `Figura` de modo que todo o seu CSS só estilize o que
está dentro da `Figura`.

[image]

Abrir mão do posicionamento significa deixar essa responsabilidade para os
componentes que usam `Figura` dentro de si. `Galeria` poderia, portanto,
controlar o layout de vários componentes `Figura` da forma que quisesse.
Estilizar componentes de fora pra dentro – em vez de dentro pra fora – permite
que as responsabilidades sejam bem definidas e que cada componente seja
altamente reutilizável.

[image with many usages of gallery and figure]

Recentemente trabalhei em um projeto que não seguiu este hábito em alguns de
seus componentes. O componentes de `Botão`, neste caso, tentavam ser
inteligentes quanto ao espaçamento entre si. Eles usaram um seletor como
`.botao + .botao` para adicionar `margin`, criando um espaçamento automático
para quem os usasse repetidamente no código.

[image of buttons being repeatedly used in a form]

Por não abrir mão do posicionamento, tivemos que reescrever vários outros
componentes que usavam `Botão` dentro de si no momento que o espaçamento já não
era desejado em certos casos.

Se desde o começo o espaçamento fosse responsabilidade dos componentes que
englobam os botões, este problema poderia ter sido resolvido sem a necessidade
de grandes alterações.

## Abrir mão do tamanho

Assim como abrir mão do posicionamento, abrir mão do tamanho também é um ótimo
hábito para escrever CSS escalável. Na página de galeria que nós acabamos de
implementar, nós poderíamos ter estilizado o componente `Figura` de tal forma
que seu `width` estaria fixo em `300px`, já que este é o tamanho exato deste
elemento no design. Porém, se decidirmos utilizar `Figura` dentro de um
elemento menor, nós teríamos problemas.

Ao abrir mão do espaçamento, delegamos ao máximo a definição real do tamanho de
um elemento na tela. Isso significa que quase todos os seus componentes seriam
estilizados com `width: 100%`, de modo que quem os engloba pode decidir seu
tamanho real final.

[image]

Existem alguns casos em que não é possível abrir mão do tamanho dos nossos
componentes. É, por exemplo, muito difícil estilizar um componente complexo
para comportar tamanhos muito grandes e muito pequenos sem o uso de _media
queries_. Não existe hoje uma forma de estilizar um componente baseado em seu
tamanho na tela, já que ainda não temos algo como Container Queries no CSS.

Mantenha sempre em mente que nenhuma solução técnica vem sem desvantagens. Para
componentes assim, talvez o ideal seja ter diferentes versões dos seus estilos
que podem ser utilizadas usando uma classe no elemento principal para definir
uma versão "enxuta" ou "completa".

[image]

## Deixar o conteúdo fluir

Conteúdo é quase sempre o centro de um design. E em muitas interfaces de
usuário dinâmicas, é muito difícil saber ao certo o tamanho de um texto, imagem
ou vídeo. Botões podem ter mais texto do que cabe em apenas uma linha. Imagens
talvez sejam estreitas e não quadradas. Títulos podem ter palavras que não
cabem inteiras na largura de um dispositivo móvel. Conteúdo é dinâmico, e seus
componentes devem deixá-lo fluir.

Existem basicamente duas maneiras de lidar com a diversidade de conteúdo:
forçar o conteúdo para se adaptar ao seu componente (abordagem controlada)
e adaptar o componente ao conteúdo (abordagem fluída).

### Abordagem controlada

Para forçar o conteúdo a se adaptar a um componente, podemos usar `overflow:
hidden`, `width` e `height` fixos, `text-overflow: ellipsis` e muitas outras
regras. Esta abordagem normalmente é necessária quando temos que manter um
balanço  e prevenir que um conteúdo gerado pelos usuários quebre a interface.

[image]

O problema de tentar controlar o conteúdo é que uma mudança nos requerimentos
deste conteúdo pode nos forçar a refatorar todos os componentes que não se
adaptam ao conteúdo.

### Abordagem fluída

Uma outra forma de lidar com conteúdo é com uma abordagem fluída. Se quase
todos os nossos componentes seguirem essa abordagem, teremos uma interface de
usuário flexível que se adapta tanto ao conteúdo quanto ao dispositivo. O CSS
tende a nos levar por este caminho, já que a maioria dos valores padrão foram
definidos com o intuito de deixar o conteúdo fluir. Novas técnicas de layout
como Flexbox e Grid CSS também têm valores padrão onde o conteúdo é uma parte
bastante importante nas definições de posicionamento e espaçamento.

Pode ser um pouco assustador não ter o controle total de como um componente ou
toda a sua interface de usuário aparecerá para o usuário final. Ao usar algumas
regras como `overflow-wrap: break-word` e `min-width: 200px` definimos limites
de como o conteúdo vai fluir dentro dos nossos componentes, tendo um pouco mais
de controle, mas não o suficiente para limitar demais o conteúdo.

[image overflow-wrap]

## Resumo

Os três hábitos apresentados se complementam para nos guiar na estilização de
interfaces de usuário na web. CSS é uma ferramenta muito poderosa e nem sempre
muito bem compreendida.

----

Ideia para imagens: outline, tela escura
