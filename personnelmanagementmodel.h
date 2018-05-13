#ifndef PERSONNELMANAGEMENTMODEL_H
#define PERSONNELMANAGEMENTMODEL_H

#include <QSqlQueryModel>

class PersonnelManagementModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit PersonnelManagementModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    void generateRoleNames();

private:
    QHash<int, QByteArray> m_rNames;
};

#endif // PERSONNELMANAGEMENTMODEL_H
