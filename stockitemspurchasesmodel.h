#ifndef STOCKITEMSPURCHASESMODEL_H
#define STOCKITEMSPURCHASESMODEL_H

#include <QAbstractListModel>

class StockItemsPurchasesList;

class StockItemsPurchasesModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(StockItemsPurchasesList *list READ list WRITE setList)
    Q_PROPERTY(int listItemCount READ listItemCount NOTIFY listItemCountChanged)

public:
    explicit StockItemsPurchasesModel(QObject *parent = nullptr);

    enum {
        itemNameRole = Qt::UserRole + 1,
        itemSizeRole,
        quantityRole,
        pricePerUnitRole,
        totalCostRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    StockItemsPurchasesList *list() const;
    void setList(StockItemsPurchasesList *list);

    int listItemCount() const;

signals:
    void listItemCountChanged(int count);

private:
    StockItemsPurchasesList *m_list;
    int m_listItemCount;
};

#endif // STOCKITEMSPURCHASESMODEL_H
