#ifndef STOCKITEMSMODEL_H
#define STOCKITEMSMODEL_H

#include <QSqlTableModel>

class StockItemsModel : public QSqlTableModel
{
    Q_OBJECT

public:
    explicit StockItemsModel(QObject *parent = nullptr);

    Q_INVOKABLE QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    void reload();
    bool setQuantity(int rowIndex, int quantity);
};

#endif // STOCKITEMSMODEL_H
