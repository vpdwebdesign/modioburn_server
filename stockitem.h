#ifndef STOCKITEM_H
#define STOCKITEM_H

#include <QString>

struct StockItem
{
    QString itemName;
    QString itemSize;
    int quantity;
    double pricePerUnit;
    double totalCost;
};

#endif // STOCKITEM_H
