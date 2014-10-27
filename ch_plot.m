function ch_plot
global recobj
global figUIobj

switch recobj.plot
    case 1
        set(figUIobj.p1, 'Color','b');
        set(figUIobj.p2, 'Color','b');
        set(get(figUIobj.s1, 'Ylabel'), 'string','mV');
        set(get(figUIobj.s2, 'Title'), 'string','V-DATA');
        set(get(figUIobj.s2, 'Ylabel'), 'string','mV');
    case 2
        set(figUIobj.p1, 'Color','r');
        set(figUIobj.p2, 'Color','r');
        set(get(figUIobj.s1, 'Ylabel'), 'string','nA');
        set(get(figUIobj.s2, 'Title'), 'string','I-DATA');
        set(get(figUIobj.s2, 'Ylabel'), 'string','nA');
end