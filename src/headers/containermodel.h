#ifndef CONTAINERMODEL_H
#define CONTAINERMODEL_H

#include <QAbstractListModel>

/*template < typename U = QVariant, typename V = QList<U> >
class ContainerListModel : public QAbstractListModel
{

    Q_OBJECT;

public:

    explicit ContainerListModel(QObject* parent = 0) :QAbstractListModel( parent ) {}
    virtual ~ContainerListModel();

    const V& m_container = m_data;

public slots:

    inline QModelIndex index( int row, int column, const QModelIndex &parent = QModelIndex() ) const override {
        Q_UNUSED( parent );
        return createIndex( row, column, m_columnCount * row + column );
    }

    inline QModelIndex parent( const QModelIndex &index ) const override {
        if(index.parent() != QModelIndex()) {
            return index.parent();
        } else {
            return QModelIndex();
        }
    }

    inline QVariant data( const QModelIndex &index, int role ) const override
    {
        if (index.row() < 0 || index.row() >= m_data.size())
        {
            return QVariant();
        }
        QVariant* entry = m_data.at( index.row() );
        for(auto i& : roleNames())
        return entry;
    }

    inline int rowCount( const QModelIndex& parent = QModelIndex() ) const override
    {
        Q_UNUSED(parent);
        if ( parent != QModelIndex() ){
            return m_data.size();
        } else {

        }
    }

    inline int columnCount( const QModelIndex& parent = QModelIndex() ) const override
    {
        Q_UNUSED(parent);
        return m_columnCount;
    }


    inline bool hasChildren( const QModelIndex &parent = QModelIndex() ) const override
    {
        if ( rowCount( parent ) > 0 ) {
            return true;
        } else {
            return false;
        }
    }

    inline bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole  ) override
    {
        bool ret = false;
        U* item = m_data.at( index.row() );
        //const QByteArray roleName = (role != Qt::DisplayRole ? _roles.value(role, emptyBA()) : _displayRoleName);
        if ( role != Qt::EditRole) {
            m_data[ index.internalId() ].role = value;
        } else {
            m_data[ index.internalId() ] = value;
        }
        emit dataChanged( index );
        return true;
    }

    inline bool setItemData(const QModelIndex &index, const QMap<int, QVariant> &roles ) override
    {
        if ( role != Qt::EditRole) {
            m_data[ index.internalId() ].role = value;
        } else {
            m_data[ index.internalId() ] = value;
        }
        emit dataChanged( index );
    }

protected:

    QHash < int, QByteArray > roleNames() const;


private:

    V m_data;

    int m_columnCount { 1 };

};
*/
#endif // CONTAINERMODEL_H
