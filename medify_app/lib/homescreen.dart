import 'package:flutter/material.dart';
import 'dart:async'; // Necessário para o carrossel automático

//HOME
class PaginaSaude extends StatelessWidget {
  const PaginaSaude({super.key});

  @override
  Widget build(BuildContext context) {
    const Color(0xff0068E0);
    const backgroundColor = Color(0xFFE6F0FC);
    const cardColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,

      //APPBAR 80 de altura, com foto do usuário, nome e ícone de notificações
      appBar: AppBar(
        toolbarHeight: 80, //AUMENTA A ALTURA DA APPBAR
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0, //SOMBRA DA APPBAR PARA DAR UM EFEITO DE PROFUNDIDADE
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
          child: const CircleAvatar(
            backgroundColor: Color(0xff0068E0),
            child: Icon(Icons.person, color: Colors.white),
            //ICONE PADRAO PARA NAO DAR ERRO
          ),
        ),
        title: const Text(
          'Olá, Lúcio!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none, color: Color(0xff0068E0)),
              ),
            ),
          ),
        ],
      ),
      // FIM DA APPBAR

      // CORPO DA PÁGINA COM ROLAGEM VERTICAL
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Boas vindas!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xff0068E0),
              ),
            ),

            // ESPAÇO ENTRE O TÍTULO E O CARD
            const SizedBox(height: 10),

            //CARD UNIDADE DE SAÚDE
            Card(
              color: cardColor,
              elevation: 0, // REMOVE A SOMBRA DO CARD PARA UM VISUAL MAIS LIMPO
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Unidade de Saúde selecionada:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF005f6B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'UBS Bairro do Carmo',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const Text(
                      'Rua Nossa Senhora do Carmo, 000',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 16),

                    // LINHA DE BOTÕES
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        //BOTÃO MAIS DETALHES
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE0F2FE),
                            foregroundColor: Color(0xff0068E0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Mais detalhes'),
                        ),

                        // ESPAÇO ENTRE OS DOIS BOTÕES
                        const SizedBox(width: 8),

                        // BOTÃO TROCAR UNIDADE
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff0068E0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Trocar unidade'),
                        ),
                      ],
                    ),
                    // FIM DA LINHA DE BOTÕES

                  ],
                ),
              ),
            ),
            // Fim do card unidade de saúde

            // ESPAÇO ENTRE O CARD E O CARROSSEL
            const SizedBox(height: 24),

            //CARROSEL AUTOMATICO COM 3 IMAGENS DE DESTAQUES (NOVEMBRO AZUL, FARMÁCIA POPULAR E DIA MUNDIAL DO AUTISMO)
            const CarrosselDestaques(),

            // ESPAÇO ENTRE O CARROSSEL E O ACESSO RÁPIDO
            const SizedBox(height: 24),

            // ACESSO RÁPIDO (Título)
            const Text(
              'Acesso rápido',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xff0068E0),
              ),
            ),

            // ESPAÇO ENTRE O TÍTULO E OS ITENS DE ACESSO RÁPIDO
            const SizedBox(height: 10),

            //ACESSO RÁPIDO COM ROLAGEM HORIZONTAL AQUI
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickAccessCard(
                    context,
                    Icons.local_hospital_outlined,
                    'UBSs',
                    'ubss_screen',
                  ),
                  _buildQuickAccessCard(
                    context,
                    Icons.apartment_outlined,
                    'Hospitais',
                    'hospitais_screen',
                  ),
                  _buildQuickAccessCard(
                    context,
                    Icons.assignment_outlined,
                    'Receitas médicas',
                    'receitas_screen',
                  ),
                  _buildQuickAccessCard(
                    context,
                    Icons.campaign_outlined,
                    'Campanhas',
                    'campanhas_screen',
                  ),
                  _buildQuickAccessCard(
                    context,
                    Icons.info_outline,
                    'Informações',
                    'informacoes_screen',
                  ),
                ],
              ),
            ),
            // Fim do acesso rápido

            // ESPAÇO ENTRE O ACESSO RÁPIDO E O PRÓXIMO EVENTO
            const SizedBox(height: 24),

            // PRÓXIMO EVENTO (Título)
            const Text(
              'Próximo evento',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xff0068E0),
              ),
            ),

            // 'ESPACO ENTRE O TÍTULO E O CARD
            const SizedBox(height: 10),

            //CARD PROXIMO EVENTO
            Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Nenhuma consulta ou exame foi agendado ainda.',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),

      // BARRA DE NAVEGAÇÃO INFERIOR COM 5 ITENS, SENDO O DO MEIO UM BOTÃO DE AGENDAR MAIOR E COLORIDO
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: Colors.white,
          height: 110,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF005f6B),
            unselectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),

            currentIndex: 0,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_filled, size: 30),
                label: 'Início',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.medical_services_outlined, size: 30),
                label: 'Consultas',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF00796B),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.add, size: 40, color: Colors.white), // Gotão agendar
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline, size: 30),
                label: 'Exames',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 30),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  //FUNCAO PARA CRIAR ITENS ACESSO RAPIDO
  Widget _buildQuickAccessCard(
    BuildContext context,
    IconData icon,
    String label,
    String routeName,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        width: 105,
        height: 140,
        margin: const EdgeInsets.only(right: 8.0),
        child: Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 37, color: const Color(0xFF005F6B)),
                const SizedBox(height: 30),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//WIDGET DO CARROSSEL AUTOMÁTICO
class CarrosselDestaques extends StatefulWidget {
  const CarrosselDestaques({super.key});

  @override
  State<CarrosselDestaques> createState() => _CarrosselDestaquesState();
}

class _CarrosselDestaquesState extends State<CarrosselDestaques> {
  final PageController _pageController = PageController(initialPage: 0);
  int _paginaAtual = 0;
  Timer? _timer;

  //LISTA COM IMAGENS DO BANNER
  final List<Map<String, String>> _itensDestaque = [
    {'imagemUrl': 'assets/images/banner_novembro_azul.png'},
    {'imagemUrl': 'assets/images/banner_farmacia_popular.png'},
    {'imagemUrl': 'assets/images/banner_autismo.png'},
  ];

  @override
  void initState() {
    super.initState();
    //MUDA A IMAGEM A CADA 4 SEGUNDOS
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_paginaAtual < _itensDestaque.length - 1) {
        _paginaAtual++;
      } else {
        _paginaAtual = 0;
      }

      _pageController.animateToPage(
        _paginaAtual,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color(0xff0068E0);

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2.47,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _itensDestaque.length,
            onPageChanged: (int page) {
              setState(() {
                _paginaAtual = page;
              });
            },
            itemBuilder: (context, index) {
              var item = _itensDestaque[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  item['imagemUrl']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.blueGrey);
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        //3 PONTOS INDICADORES
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_itensDestaque.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _paginaAtual == index ? Color(0xff0068E0) : Colors.grey[400],
              ),
            );
          }),
        ),
      ],
    );
  }
}
