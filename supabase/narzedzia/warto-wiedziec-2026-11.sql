-- =============================================================================
--  TALERZ — uwagi „Warto wiedzieć” dla 12 składników (listopad 2026)
-- =============================================================================
--  Wykonanie: SQL Editor w panelu Supabase. Wymaga migracji 0052.
--
--  Dopasowanie po nazwie, bez względu na wielkość liter. Istniejąca uwaga
--  zostaje ZASTĄPIONA (dotyczy m.in. siemienia lnianego i chia z migracji
--  0052). Na końcu sprawdzenie: każdy wiersz ma mieć „zapisano = TAK”.
--  „BRAK W KATALOGU” znaczy, że składnik nazywa się w bazie inaczej.
-- =============================================================================

with uwagi (nazwa, tresc) as (
  values
    ('Siemię lniane',
     'Zmiel przed dodaniem do owsianki, jogurtu lub pasty — całe nasiona mogą przejść przez przewód pokarmowy niestrawione. Rozdrobnienie ułatwia wykorzystanie zawartych w nich tłuszczów omega-3 ALA i lignanów.'),
    ('Nasiona chia',
     'Wymieszaj z jogurtem, mlekiem lub wodą i pozostaw do napęcznienia. Nasiona tworzą żel dzięki zawartości błonnika i naturalnie zagęszczają potrawę. Nie połykaj ich na sucho.'),
    ('Orzechy włoskie',
     'Dostarczają roślinnych kwasów omega-3 ALA. Dodaj je do owsianki, sałatki lub pasty — pamiętaj jednak, że organizm przekształca ALA w kwasy EPA i DHA obecne w rybach tylko w niewielkim stopniu.'),
    ('Płatki owsiane',
     'Zawierają beta-glukany — rodzaj rozpuszczalnego błonnika, który w owsiance odpowiada za kremową konsystencję. Ich ilość liczy się w gramach beta-glukanów, nie płatków.'),
    ('Otręby owsiane',
     'Są źródłem błonnika, w tym beta-glukanów. Możesz dodawać je do owsianki, jogurtu lub ciasta. Jeśli dotychczas jesz mało błonnika, zwiększaj jego ilość stopniowo i pamiętaj o płynach.'),
    ('Pomidory, surowe',
     'Zawierają likopen, który organizm łatwiej przyswaja po rozdrobnieniu i podgrzaniu pomidorów, szczególnie z dodatkiem niewielkiej ilości tłuszczu. Warto jeść pomidory zarówno na surowo, jak i w sosach.'),
    ('Koncentrat pomidorowy',
     'Jest skoncentrowanym źródłem likopenu. Dodaj go do sosu, zupy lub potrawki z niewielką ilością oliwy albo oleju — tłuszcz ułatwia przyswajanie tego barwnika.'),
    ('Papryka czerwona, surowa',
     'Dodaj ją na surowo do posiłku z soczewicą, fasolą lub ciecierzycą — zawarta w niej witamina C poprawia przyswajanie żelaza ze składników roślinnych. Długie gotowanie zmniejsza zawartość tej witaminy.'),
    ('Soczewica zielona, sucha',
     'Dostarcza białka roślinnego, błonnika i żelaza. Po ugotowaniu podawaj ją z surową papryką lub dodatkiem soku z cytryny — witamina C poprawia przyswajanie żelaza z roślin.'),
    ('Szpinak, surowy',
     'Zawiera żelazo, ale organizm przyswaja tylko część jego zawartości. Dodatek papryki, truskawek lub soku z cytryny dostarcza witaminy C, która poprawia przyswajanie żelaza roślinnego.'),
    ('Kefir naturalny 2%',
     'Jeśli zależy Ci na żywych kulturach mikroorganizmów, pij go bez podgrzewania lub dodawaj do przestudzonej potrawy. Sama fermentacja nie oznacza jednak, że produkt ma potwierdzone działanie probiotyczne.'),
    ('Kapusta kiszona',
     'Niepasteryzowana kapusta może zawierać żywe bakterie fermentacji mlekowej. Podgrzewanie zmniejsza ich liczbę i może je zniszczyć. Jeśli chcesz je zachować, podawaj kapustę na zimno i sprawdź na opakowaniu, czy była pasteryzowana.')
),
zapisane as (
  update skladniki s
     set warto_wiedziec = u.tresc
    from uwagi u
   where lower(s.nazwa) = lower(u.nazwa)
  returning s.nazwa
)
select u.nazwa,
       case when exists (select 1 from zapisane z where lower(z.nazwa) = lower(u.nazwa))
            then 'TAK' else 'BRAK W KATALOGU' end as zapisano
  from uwagi u
 order by u.nazwa;
