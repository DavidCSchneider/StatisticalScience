Options linesize=80; 
Title1 'Death by horsekick, Prussian Army, by year and corps';
Title2 'by year and duty, A=guard+first, B=2nd+3rd';
data d1;
 input Year 1-4 Count 7 Duty $ 10 Corps $ 12-16;
cards;
1875  0  A guard
1876  2  A guard
1877  2  A guard
1878  1  A guard
1879  0  A guard
1880  0  A guard
1881  1  A guard
1882  1  A guard
1883  0  A guard
1884  3  A guard
1885  0  A guard
1886  2  A guard
1887  1  A guard
1888  0  A guard
1889  0  A guard
1890  1  A guard
1891  0  A guard
1892  1  A guard
1893  0  A guard
1894  1  A guard
1875  0  A first
1876  0  A first
1877  0  A first
1878  2  A first
1879  0  A first
1880  3  A first
1881  0  A first
1882  2  A first
1883  0  A first
1884  0  A first
1885  0  A first
1886  1  A first
1887  1  A first
1888  1  A first
1889  0  A first
1890  2  A first
1891  0  A first
1892  3  A first
1893  1  A first
1894  0  A first
1875  0  B second
1876  0  B second
1877  0  B second
1878  2  B second
1879  0  B second
1880  2  B second
1881  0  B second
1882  0  B second
1883  1  B second
1884  1  B second
1885  0  B second
1886  0  B second
1887  2  B second
1888  1  B second
1889  1  B second
1890  0  B second
1891  0  B second
1892  2  B second
1893  0  B second
1894  0  B second
1875  0  B third
1876  0  B third
1877  0  B third
1878  2  B third
1879  0  B third
1880  2  B third
1881  0  B third
1882  0  B third
1883  1  B third
1884  1  B third
1885  0  B third
1886  0  B third
1887  2  B third
1888  1  B third
1889  1  B third
1890  0  B third
1891  0  B third
1892  2  B third
1893  0  B third
1894  0  B third
;

data d2;  set d1; if corps = 'guard';
Title3 'Guard only.  Poisson regression against year.';
Proc Genmod; 
  model Count = Year/
  link=log dist=poisson type1 type3;
