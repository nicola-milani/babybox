// ============================================================
//  Verifiche di accettazione del task 6 — controllo genitori
// ------------------------------------------------------------
//  Girano sul Mac in un secondo, senza hardware:
//      ./firmware/prove.sh
//
//  Ogni blocco qui sotto corrisponde a una riga di
//  tasks/task-06-controllo-genitori.md. Scritte prima del
//  modulo, come chiede CLAUDE.md.
// ============================================================
#include "../controllo-genitori/ControlloGenitori.h"

#include <cstdio>
#include <cstring>
#include <string>

using namespace box;

// ---------- minuscola impalcatura di prova ----------
static int falliti = 0;
static int totali = 0;
static std::string provaCorrente;

static void prova(const char *nome) {
	provaCorrente = nome;
	printf("\n  %s\n", nome);
}

static void verifica(bool condizione, const char *cosa) {
	totali++;
	if (condizione) {
		printf("    ok   %s\n", cosa);
	} else {
		falliti++;
		printf("    NO   %s\n", cosa);
	}
}

// ---------- scenario di riferimento ----------
// Nanna del pomeriggio 13:00-15:30 e notte 20:30-07:00, tutti i giorni.
// Una storia concessa per fascia, volume dimezzato (7 invece di 14).
static Regole regoleDiCasa() {
	Regole r;
	r.volumeMassimoNormale = 14;
	r.dissolvenzaSecondi = 30;
	for (int g = 0; g < 7; g++) {
		r.fasce[g][0] = {true, 13 * 60, 15 * 60 + 30, 1, 7};
		r.fasce[g][1] = {true, 20 * 60 + 30, 7 * 60, 1, 7}; // scavalca la mezzanotte
	}
	return r;
}

// Lunedì 1 gennaio 2026 = giorno epoca 20454 (il numero serve solo a
// distinguere una fascia dall'altra, non a fare i conti col calendario).
static Orario quando(int minuti, int giornoSettimana = 0, int giornoEpoca = 20454,
					 bool affidabile = true) {
	return Orario {giornoEpoca, minuti, giornoSettimana, affidabile};
}

static const char *VOLPE = "044213706D5E80";
static const char *DRAGO = "04A1B2C3D4E5F6";
static const char *NINNA = "04FFEEDDCCBBAA";

int main() {
	printf("Verifiche del controllo genitori\n");

	// ------------------------------------------------------------
	prova("Fuori dalle fasce il box è normale");
	{
		ControlloGenitori cg(regoleDiCasa());
		auto d = cg.tagAppoggiato(quando(10 * 60), VOLPE, Tipo::Storia);
		verifica(d.esito == Esito::Normale, "alle 10:00 la storia parte senza limiti");
		verifica(d.volumeMassimo == 14, "vale il volume massimo dei genitori");
		verifica(!d.inFascia, "non siamo in fascia di riposo");
		verifica(!cg.riposoBloccato(quando(10 * 60)), "niente schermata della luna");
	}

	// ------------------------------------------------------------
	prova("1. In fascia la prima statuina avvia normalmente la sua storia");
	{
		ControlloGenitori cg(regoleDiCasa());
		auto d = cg.tagAppoggiato(quando(13 * 60 + 10), VOLPE, Tipo::Storia);
		verifica(d.esito == Esito::Concessa, "alle 13:10 la prima storia è concessa");
		verifica(d.inFascia, "siamo in fascia di riposo");
		verifica(d.volumeMassimo == 7, "il cursore tutto a destra arriva solo a metà");
		verifica(d.dissolvenzaFinale, "è l'ultima concessa: va sfumata in chiusura");
	}

	// ------------------------------------------------------------
	prova("2 e 3. Finita la storia si entra in riposo bloccato");
	{
		ControlloGenitori cg(regoleDiCasa());
		auto o = quando(13 * 60 + 10);
		cg.tagAppoggiato(o, VOLPE, Tipo::Storia);
		cg.storiaFinita(o);

		verifica(cg.riposoBloccato(quando(14 * 60)), "la luna si accende");

		auto altra = cg.tagAppoggiato(quando(14 * 60), DRAGO, Tipo::Storia);
		verifica(altra.esito == Esito::SoloMessaggio, "un'altra statuina: solo messaggio");

		auto stessa = cg.tagAppoggiato(quando(14 * 60 + 5), VOLPE, Tipo::Storia);
		verifica(stessa.esito == Esito::SoloMessaggio, "la stessa rimessa: solo messaggio");

		auto tasto = cg.tastoPremuto(quando(14 * 60 + 6));
		verifica(tasto.esito == Esito::SoloMessaggio, "i tasti: solo messaggio");
	}

	// ------------------------------------------------------------
	prova("4. Togliere e rimettere la stessa statuina durante la storia non conta");
	{
		ControlloGenitori cg(regoleDiCasa());
		auto o = quando(13 * 60 + 10);
		cg.tagAppoggiato(o, VOLPE, Tipo::Storia);
		cg.tagTolto(quando(13 * 60 + 12), VOLPE);
		auto d = cg.tagAppoggiato(quando(13 * 60 + 13), VOLPE, Tipo::Storia);
		verifica(d.esito == Esito::Riprendi, "riprende da dov'era");
		verifica(cg.stato().storieUsate == 1, "resta una sola storia consumata");

		// ma un'altra statuina mentre la concessa è in corso è un tentativo nuovo
		auto altra = cg.tagAppoggiato(quando(13 * 60 + 14), DRAGO, Tipo::Storia);
		verifica(altra.esito == Esito::SoloMessaggio, "un'altra statuina resta bloccata");
	}

	// ------------------------------------------------------------
	prova("5. A fine fascia il box torna normale");
	{
		ControlloGenitori cg(regoleDiCasa());
		auto o = quando(13 * 60 + 10);
		cg.tagAppoggiato(o, VOLPE, Tipo::Storia);
		cg.storiaFinita(o);
		verifica(cg.tagAppoggiato(quando(15 * 60), DRAGO, Tipo::Storia).esito == Esito::SoloMessaggio,
				 "alle 15:00 siamo ancora bloccati");
		auto dopo = cg.tagAppoggiato(quando(16 * 60), DRAGO, Tipo::Storia);
		verifica(dopo.esito == Esito::Normale, "alle 16:00 la fascia è finita");
		verifica(dopo.volumeMassimo == 14, "torna il volume pieno");
		verifica(!cg.riposoBloccato(quando(16 * 60)), "la luna si spegne");
	}

	// ------------------------------------------------------------
	prova("6. Una canzone conta come una storia");
	{
		ControlloGenitori cg(regoleDiCasa());
		auto o = quando(13 * 60 + 10);
		verifica(cg.tagAppoggiato(o, NINNA, Tipo::Musica).esito == Esito::Concessa,
				 "il primo vinile è concesso");
		cg.storiaFinita(o);
		verifica(cg.tagAppoggiato(quando(13 * 60 + 20), VOLPE, Tipo::Storia).esito == Esito::SoloMessaggio,
				 "dopo il vinile la statuina è bloccata");
	}

	// ------------------------------------------------------------
	prova("La fascia che scavalca la mezzanotte è una sola fascia");
	{
		ControlloGenitori cg(regoleDiCasa());
		// lunedì 21:00: dentro la fascia della notte
		auto sera = cg.tagAppoggiato(quando(21 * 60, 0, 20454), VOLPE, Tipo::Storia);
		verifica(sera.esito == Esito::Concessa, "alle 21:00 la storia della buonanotte è concessa");
		cg.storiaFinita(quando(21 * 60 + 20, 0, 20454));
		// martedì 06:00: stessa fascia, non una nuova
		auto notte = cg.tagAppoggiato(quando(6 * 60, 1, 20455), DRAGO, Tipo::Storia);
		verifica(notte.esito == Esito::SoloMessaggio, "alle 06:00 del giorno dopo è ancora la stessa notte");
		// martedì 08:00: fuori fascia
		verifica(cg.tagAppoggiato(quando(8 * 60, 1, 20455), DRAGO, Tipo::Storia).esito == Esito::Normale,
				 "alle 08:00 si ricomincia");
	}

	// ------------------------------------------------------------
	prova("Storie concesse a zero: solo messaggio fin dal primo tentativo");
	{
		Regole r = regoleDiCasa();
		for (int g = 0; g < 7; g++) {
			r.fasce[g][0].storieConcesse = 0;
		}
		ControlloGenitori cg(r);
		auto d = cg.tagAppoggiato(quando(13 * 60 + 10), VOLPE, Tipo::Storia);
		verifica(d.esito == Esito::SoloMessaggio, "niente storia, solo il messaggio");
		verifica(cg.riposoBloccato(quando(13 * 60 + 10)), "la luna è accesa da subito");
	}

	// ------------------------------------------------------------
	prova("Due storie concesse: la seconda passa, la terza no");
	{
		Regole r = regoleDiCasa();
		for (int g = 0; g < 7; g++) {
			r.fasce[g][0].storieConcesse = 2;
		}
		ControlloGenitori cg(r);
		auto prima = cg.tagAppoggiato(quando(13 * 60 + 5), VOLPE, Tipo::Storia);
		verifica(prima.esito == Esito::Concessa, "la prima passa");
		verifica(!prima.dissolvenzaFinale, "non è l'ultima: niente dissolvenza");
		cg.storiaFinita(quando(13 * 60 + 20));
		auto seconda = cg.tagAppoggiato(quando(13 * 60 + 21), DRAGO, Tipo::Storia);
		verifica(seconda.esito == Esito::Concessa, "la seconda passa");
		verifica(seconda.dissolvenzaFinale, "l'ultima concessa va sfumata");
		cg.storiaFinita(quando(13 * 60 + 40));
		verifica(cg.tagAppoggiato(quando(13 * 60 + 41), NINNA, Tipo::Musica).esito == Esito::SoloMessaggio,
				 "la terza no");
	}

	// ------------------------------------------------------------
	prova("Nanna adesso: blocca subito e scade da sola");
	{
		ControlloGenitori cg(regoleDiCasa());
		auto o = quando(17 * 60); // fuori da ogni fascia
		verifica(cg.tagAppoggiato(o, VOLPE, Tipo::Storia).esito == Esito::Normale,
				 "alle 17:00 si ascolta normalmente");
		cg.nannaAdesso(o, 60);
		auto durante = cg.tagAppoggiato(quando(17 * 60 + 10), VOLPE, Tipo::Storia);
		verifica(durante.esito == Esito::SoloMessaggio, "con la nanna accesa: solo messaggio");
		verifica(durante.inFascia, "per lo schermo è riposo a tutti gli effetti");
		verifica(cg.tagAppoggiato(quando(18 * 60 + 1), VOLPE, Tipo::Storia).esito == Esito::Normale,
				 "dopo un'ora la nanna è scaduta");
	}

	prova("Nanna fino al mattino");
	{
		ControlloGenitori cg(regoleDiCasa());
		cg.nannaAdesso(quando(17 * 60), 0); // 0 = fino al mattino
		verifica(cg.tagAppoggiato(quando(19 * 60), VOLPE, Tipo::Storia).esito == Esito::SoloMessaggio,
				 "alle 19:00 è ancora nanna");
		verifica(cg.tagAppoggiato(quando(6 * 60, 1, 20455), VOLPE, Tipo::Storia).esito == Esito::SoloMessaggio,
				 "alle 06:00 del giorno dopo è ancora nanna");
		verifica(cg.tagAppoggiato(quando(8 * 60, 1, 20455), VOLPE, Tipo::Storia).esito == Esito::Normale,
				 "alle 08:00 è finita");
	}

	// ------------------------------------------------------------
	prova("Lo spegnimento non azzera il blocco");
	{
		Stato salvato;
		{
			ControlloGenitori cg(regoleDiCasa());
			auto o = quando(13 * 60 + 10);
			cg.tagAppoggiato(o, VOLPE, Tipo::Storia);
			cg.storiaFinita(o);
			salvato = cg.stato(); // è quello che il box scrive in NVS
		}
		ControlloGenitori riacceso(regoleDiCasa(), salvato);
		verifica(riacceso.tagAppoggiato(quando(14 * 60), VOLPE, Tipo::Storia).esito == Esito::SoloMessaggio,
				 "riaccendendo il box la storia resta bloccata");
		verifica(riacceso.riposoBloccato(quando(14 * 60)), "e la luna è ancora lì");
	}

	// ------------------------------------------------------------
	prova("Ora non affidabile: vale la regola più restrittiva");
	{
		Regole r = regoleDiCasa();
		r.fasce[0][0].storieConcesse = 3;   // una fascia generosa
		r.fasce[0][0].volumeMassimo = 12;
		r.fasce[0][1].storieConcesse = 0;   // e una severa
		r.fasce[0][1].volumeMassimo = 5;
		ControlloGenitori cg(r);
		auto d = cg.tagAppoggiato(quando(10 * 60, 0, 20454, false), VOLPE, Tipo::Storia);
		verifica(d.oraNonAffidabile, "la decisione dice che l'ora non è attendibile");
		verifica(d.esito == Esito::SoloMessaggio, "vale la fascia più severa: zero storie");
		verifica(d.volumeMassimo == 5, "e il suo volume ridotto");
	}

	prova("Ora non affidabile senza fasce impostate: il box resta usabile");
	{
		Regole r;              // nessuna fascia attiva
		r.volumeMassimoNormale = 14;
		ControlloGenitori cg(r);
		auto d = cg.tagAppoggiato(quando(10 * 60, 0, 20454, false), VOLPE, Tipo::Storia);
		verifica(d.esito == Esito::Normale, "senza regole non c'è niente da far rispettare");
		verifica(d.oraNonAffidabile, "ma lo si segnala comunque alla web UI");
	}

	// ------------------------------------------------------------
	prova("Accettazione: le modifiche dal telefono valgono dal tentativo dopo");
	{
		Regole r = regoleDiCasa();
		ControlloGenitori cg(r);
		verifica(cg.tagAppoggiato(quando(16 * 60), VOLPE, Tipo::Storia).esito == Esito::Normale,
				 "alle 16:00 si ascolta");
		// il genitore allunga la nanna del pomeriggio fino alle 17:00 dal telefono
		for (int g = 0; g < 7; g++) {
			r.fasce[g][0].fine = 17 * 60;
		}
		cg.aggiornaRegole(r);
		verifica(cg.tagAppoggiato(quando(16 * 60 + 1), DRAGO, Tipo::Storia).esito == Esito::Concessa,
				 "il tentativo successivo rispetta già la regola nuova");
	}

	// ------------------------------------------------------------
	printf("\n%d verifiche, %d fallite\n", totali, falliti);
	return falliti == 0 ? 0 : 1;
}
